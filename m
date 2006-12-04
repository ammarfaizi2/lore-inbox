Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937326AbWLDTu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937326AbWLDTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937351AbWLDTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:50:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:14082 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937346AbWLDTuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:50:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="170060936:sNHT18073244"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] remove redundant iov segment check
Date: Mon, 4 Dec 2006 11:50:53 -0800
Message-ID: <000501c717dd$81f72ee0$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccX242RLX4Fylh0QKG8e0vt09loRwAAWNKg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061204113609.753069b9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Monday, December 04, 2006 11:36 AM
> On Mon, 4 Dec 2006 08:26:36 -0800
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> 
> > So it's not possible to call down to generic_file_aio_read/write with invalid
> > iov segment.  Patch proposed to delete these redundant code.
> 
> erp, please don't touch that code.
> 
> The writev deadlock fixes which went into 2.6.17 trashed writev()
> performance and Nick and I are slowly trying to get it back, while fixing
> the has-been-there-forever pagefault-in-write() deadlock.
> 
> This is all proving very hard to do, and we don't need sweeping code
> cleanups happening under our feet ;)
> 
> I'll bring those patches back in next -mm, but not very confidently.


OK, I will wait until that bug settles down and resubmit.  I really don't
see the value of walking the iov multiple times doing the same thing.

I will also dig up the archive to see if I can help in any way.

- Ken
