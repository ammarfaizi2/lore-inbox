Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUA2PDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUA2PDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 10:03:20 -0500
Received: from crafty.cis.uab.edu ([138.26.64.17]:9953 "EHLO
	crafty.cis.uab.edu") by vger.kernel.org with ESMTP id S266169AbUA2PDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 10:03:16 -0500
Date: Thu, 29 Jan 2004 09:02:41 -0600 (CST)
From: "Robert M. Hyatt" <hyatt@cis.uab.edu>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Catalin BOIE <util@deuroconsult.ro>, <linux-kernel@vger.kernel.org>,
       <linux-smp@vger.kernel.org>
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
In-Reply-To: <4018E524.8060200@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It might be some IDE disk I/O that results from flushing buffers or 
whatever.  I don't see this on my SCSI boxes, but I have seen an IDE 
box get sluggish at times due to I/O.

On Thu, 29 Jan 2004, Nick Piggin 
wrote:

> 
> 
> Catalin BOIE wrote:
> 
> >Hello!
> >
> >First, thank you very much for the effort you put for Linux!
> >
> >I have a Intel motherboard with SATA (2 Maxtor disks).
> >CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
> >1 GB RAM.
> >
> >Load: postgresql and apache. Very low load (3-4 clients).
> >
> >RAID: Yes, soft RAID1 between the 2 disks.
> >
> >I have times when the console freeze for 3-4 seconds!
> >2.6.0-test11 had the same problem (maybe longer times).
> >2.6.1-rc2 worked good in this respect but crashed after 2 days. :(
> >2.6.2-rc2 is back with the delay.
> >
> >Do you know why this can happen?
> >
> >
> 
> There haven't been many scheduler changes there recently so
> maybe its something else.
> 
> But you could try the latest -mm kernels. They have some
> Hyperthreading work in them (you need to enable CONFIG_SCHED_SMT).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-smp" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Robert M. Hyatt, Ph.D.          Computer and Information Sciences
hyatt@uab.edu                   University of Alabama at Birmingham
(205) 934-2213                  136A Campbell Hall
(205) 934-5473 FAX              Birmingham, AL 35294-1170

