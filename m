Return-Path: <linux-kernel-owner+w=401wt.eu-S1755148AbWL3Pvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbWL3Pvs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbWL3Pvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:51:48 -0500
Received: from xenotime.net ([66.160.160.81]:50943 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755148AbWL3Pvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:51:47 -0500
Date: Sat, 30 Dec 2006 07:38:23 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: dougg@torque.net
Cc: Sumant Patro <sumantp@lsil.com>, James.Bottomley@SteelEye.com,
       akpm@osdl.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       neela.kolli@lsi.com, bo.yang@lsi.com, sumant.patro@lsi.com
Subject: Re: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump
Message-Id: <20061230073823.7b1b6d71.rdunlap@xenotime.net>
In-Reply-To: <4596784A.1060001@torque.net>
References: <1167408137.4154.8.camel@dumbo>
	<20061229133741.441a5933.rdunlap@xenotime.net>
	<4596784A.1060001@torque.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006 09:31:38 -0500 Douglas Gilbert wrote:

> Randy Dunlap wrote:
> > On Fri, 29 Dec 2006 08:02:17 -0800 Sumant Patro wrote:
> > 
> > See Documentation/SubmittingPatches:
> > Please include output of "diffstat -p1 -w70" so that we can easily see
> > the scope of the changes.
> > 
> > and see Documentation/CodingStyle for comments below:
> > 
> > 
> >> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
> >> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-28 09:56:04.000000000 -0800
> >> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-29 05:31:48.000000000 -0800
> >> @@ -779,6 +780,22 @@ megaraid_init_mbox(adapter_t *adapter)
> >>  		goto out_release_regions;
> >>  	}
> >>  
> >> +	// initialize the mutual exclusion lock for the mailbox
> >> +	spin_lock_init(&raid_dev->mailbox_lock);
> > 
> > Linux uses /*...*/ C89-style comments, not // C99 comments.
> 
> Randy
> It is about time this absurd stipulation was dropped.
> Are there any C compilers that can compile the linux
> kernel and that don't accept both _standard_ comment styles?

It's not a technical issue, it's just a style point.

---
~Randy
