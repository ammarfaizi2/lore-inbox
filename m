Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTEEVT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTEEVTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:19:55 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:31431
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261374AbTEEVTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:19:49 -0400
Date: Mon, 5 May 2003 17:38:39 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Ezra Nugroho <ezran@goshen.edu>, linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
Message-ID: <20030505173839.A22502@animx.eu.org>
References: <1052153060.29588.196.camel@ezran.goshen.edu> <3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu> <3EB69883.8090609@gmx.net> <20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Mon, May 05, 2003 at 08:16:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK. Maybe I wasn't clear enough.
> > 1. Partition a drive
> > 2. Reboot
> > 3. Now the kernel should see the partitions and let you create file
> > systems on them.
> > 
> > You rebooted and fdisk sees the partitions now. Fine. Please try to
> > mke2fs /dev/md0p1
> > That should work. If it doesn't, devfs could be the problem.
> 
> 	No, it should not.  And devfs, for once, has nothing to do with it.
> RAID devices (md*) have _one_ (1) minor allocated to each.  Consequently,
> they could not be partitioned by any kernel - there is no device numbers
> to be assigned to their partitions.
>  
> > Could you please tell us which kernel version you're using?
> 
> 	What would be much more interesting, which kernel are _you_ using
> and what device numbers, in your experience, do these partitions get?

I recall an MdPart patch for the kernel that would allow this, however, it
was way too buggy for real use.  google for mdpart.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
