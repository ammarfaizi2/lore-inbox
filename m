Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVH3BIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVH3BIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVH3BIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:08:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:61657 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751438AbVH3BIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:08:53 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Lynch <rusty@linux.intel.com>
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Date: Tue, 30 Aug 2005 03:08:44 +0200
User-Agent: KMail/1.8
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Rusty Lynch <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
References: <200508262246.j7QMkEoT013490@linux.jf.intel.com> <200508270224.26423.ak@suse.de> <20050830001905.GA18279@linux.jf.intel.com>
In-Reply-To: <20050830001905.GA18279@linux.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300308.44706.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 02:19, Rusty Lynch wrote:

>
> So, assuming inlining the notifier_call_chain would address Christoph's
> conserns, is the following patch something like what you are sugesting?

Yes.

Well in theory you could make fast and slow notify_die too, but that's
probably not worth it.

-Andi
