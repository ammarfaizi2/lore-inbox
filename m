Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968381AbWLEGV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968381AbWLEGV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968382AbWLEGV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:21:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:37026 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968381AbWLEGV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:21:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,496,1157353200"; 
   d="scan'208"; a="23149832:sNHT51914205"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] add an iterator index in struct pagevec
Date: Mon, 4 Dec 2006 22:21:43 -0800
Message-ID: <000201c71835$a3e585d0$ba88030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccYMKqbUEP606tDQbuwM+gTFsrkIQAAzppg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061204214519.2260855d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Monday, December 04, 2006 9:45 PM
> On Mon, 4 Dec 2006 21:21:31 -0800
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> 
> > pagevec is never expected to be more than PAGEVEC_SIZE, I think a
> > unsigned char is enough to count them.  This patch makes nr, cold
> > to be unsigned char
> 
> Is that on the right side of the speed/space tradeoff?

I haven't measured speed.  Size wise, making them char shrinks vmlinux
text size by 112 bytes on x86_64 (using default config option).


> I must say I'm a bit skeptical about the need for this.  But I haven't
> looked closely at the blockdev-specific dio code yet.

It was suggested to declare another struct that embeds pagevec to perform
iteration.  But I prefer to have pagevec having the capability, it is
more compact this way.

It would be nice if you can review blockdev-specific dio code.  I would
appreciate it very much.

- Ken
