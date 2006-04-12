Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWDLJte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWDLJte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWDLJte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:49:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:40385 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932128AbWDLJtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:49:33 -0400
Date: Wed, 12 Apr 2006 11:49:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: Andreas Schnaiter <schnaiter@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16 -  SATA read performance drop ~50% on Intel
 82801GB/GR/GH
In-Reply-To: <443C7A92.6010604@garzik.org>
Message-ID: <Pine.LNX.4.61.0604121145040.12544@yvahk01.tjqt.qr>
References: <200604120136.28681.schnaiter@gmx.net> <443C7A92.6010604@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> hdparm usually skips the usual layers, and benchmarks the ATA command
> submission itself.  So if hdparm didn't change, that may indicate the problem
> is either in the block (scheduler?) or filesystem layers.
>
> Tests:
>
> 2) Eliminate the filesystem layer by doing dd directly to the block device (dd
> ... of=/dev/sda1) rather than dd'ing to a file on a filesystem.

Use dd_rescue (dd_rescue /dev/sda /dev/null) and watch the 'cur rate' 
marker. It should naturally drop over time (that is, it's less at the end 
of the hard disk). If it instantly drops somewhere (and the system is not 
otherwise loaded), it may indicate that the harddisk is going bad.
I have seen disks that ran previously with udma4 speeds drop down to 
900KB/s making backup to CD in the last minute a real excitement.


Jan Engelhardt
-- 
