Return-Path: <linux-kernel-owner+w=401wt.eu-S932162AbXACWeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbXACWeo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbXACWeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:34:44 -0500
Received: from mga03.intel.com ([143.182.124.21]:40816 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbXACWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:34:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="164939225:sNHT20326362"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Nick Piggin" <npiggin@suse.de>
Subject: RE: [PATCH] 4/4 block: explicit plugging
Date: Wed, 3 Jan 2007 14:34:38 -0800
Message-ID: <000001c72f87$5bd8e520$ce34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accvhj+zeMWg2e/YRHuOzuCIlbw1VQAAEf3w
In-Reply-To: <20070103222930.GL11203@kernel.dk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Wednesday, January 03, 2007 2:30 PM
> > We are having some trouble with the patch set that some of our fiber channel
> > host controller doesn't initialize properly anymore and thus lost whole
> > bunch of disks (somewhere around 200 disks out of 900) at boot time.
> > Presumably FC loop initialization command are done through block layer etc.
> > I haven't looked into the problem closely.
> > 
> > Jens, I assume the spin lock bug in __blk_run_queue is fixed in this patch
> > set?
> 
> It is. Are you still seeing problems after the initial mail exchange we
> had prior to christmas,

Yes. Not the same kernel panic, but a problem with FC loop reset itself.


> or are you referencing that initial problem?

No. we got passed that point thanks for the bug fix patch you give me
prior to Christmas.  That fixed a kernel panic on boot up.


> It's not likely to be a block layer issue, more likely the SCSI <->
> block interactions. If you mail me a new dmesg (if your problem is with
> the __blk_run_queue() fixups), I can take a look. Otherwise please do
> test with the __blk_run_queue() fixup, just use the current patchset.

I will just retake the tip of your plug tree and retest.
