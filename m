Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267637AbUBTAWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUBTAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:20:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:37601 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267591AbUBTATS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:19:18 -0500
Date: Thu, 19 Feb 2004 16:21:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1 and aic7xxx
Message-Id: <20040219162102.0b699698.akpm@osdl.org>
In-Reply-To: <200402192234.53855.cova@ferrara.linux.it>
References: <200402192234.53855.cova@ferrara.linux.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti <cova@ferrara.linux.it> wrote:
>
> I'm experiencing some problems with 2.6.3-mm1 release: on boot the system 
> hangs trying to detect scsi devices, and the light on scsi cdrom flashes 
> every few seconds. With 2.6.3-rc3-mm1 all works just fine, and I get this 
> syslog entry:
> 
> Feb 19 22:23:15 kefk kernel: ahc_pci:3:6:0: Host Adapter Bios disabled.  Using 
> default SCSI device parameters
> Feb 19 22:23:15 kefk kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
> DRIVER, Rev 6.2.36
> Feb 19 22:23:15 kefk kernel:         <Adaptec 2902/04/10/15/20C/30C SCSI 
> adapter>
> Feb 19 22:23:15 kefk kernel:         aic7850: Single Channel A, SCSI Id=7, 
> 3/253 SCBs
> 
> <<<<<<<<<<<<<<<2.6.3-mm1 hangs here

Are you able to get a sysrq-T or sysrq-P trace?

> I've also noticed (only with 2.6.3-mm1) a "PCI BIOS passed non existent PCI 
> BUS 0!" message when it probes ICH5, i.e.

Could be an acpi thing.  If you have time, could you try

	patch -p1 -R < bk-acpi.patch

and see if that helps?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/broken-out/bk-acpi.patch

Thanks.

