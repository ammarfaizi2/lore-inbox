Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265240AbTLRR1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbTLRR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:27:44 -0500
Received: from mail0.lsil.com ([147.145.40.20]:14544 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S265240AbTLRR1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:27:41 -0500
Message-Id: <0E3FA95632D6D047BA649F95DAB60E57033BC26D@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'Gonzalo Coello'" <gonzalocoello@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Not able to load megaraid module after kernel upgrade from 2.4.9-e2 to 2.4.9-e25
Date: Thu, 18 Dec 2003 12:08:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new kernel has the old driver, a paradox :-)

Grab the latest megaraid driver and compile it for your kernel, make a new
initrd image and then boot from the new kernel.

-Atul Mukker

> -----Original Message-----
> From: Gonzalo Coello [mailto:gonzalocoello@hotmail.com]
> Sent: Thursday, December 18, 2003 11:55 AM
> To: linux-kernel@vger.kernel.org
> Subject: Not able to load megaraid module after kernel upgrade from
> 2.4.9-e2 to 2.4.9-e25
> 
> 
> 
> 
> Hello I am running dell Power Edge 12600, with Firmware 1.68,
> 
> I have a Perc 4/Si RAID Controller BIOS version 1.04 FW 2.27 
> (the last 
> version)
> 
> I installer Red Hat advanced server 2.4.9-e3 and works fine, 
> the megaraid 
> driver is OK, the driver I used is 
> perc-rhas21-1194-a02.tar.gz (the last 
> one)
> 
> When I upgrade to kernel 2.4.9-e25, using the rpm provided by 
> Red hat, 
> happens the same when upgrading to any version, like 2.4.9-e21.
> 
> When starting up, the bios can recognize the disk array with 
> no problem, the 
> server starts booting OK, but when it gets to load the 
> megaraid module, it 
> brakes:
> 
> The server is not able to boot any more, here is the error:
> 
> ----------------
> 
> Red Hat nash version 3.2.6 starting
> Loading scsi_mod module
> SCSI subsystem driver Revision: 1.00
> Loading sd_mod module
> Loading megaraid module
> megaraid: v1.18 (release Date: Wed Dec 4 11:33:00 EST 2002)
> megaraid: no BIOS enabled.
> /lib/megaraid.o: init_module:
> Hint: insmod errors can be caused by incorrect module 
> parameters, including 
> invalid IO or IRQ parameters
> ERROR: /bin/insmod exited abnormally!
> Mounting /proc filesystem
> Creating root device
> Mouting root filesystem
> mount: error 19 mounting ext2
> pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> Freeing unused kernel memory: 244 freed
> Kernel panic: No init found. Try passing init= option to kernel
> 
> 
> I can clearly see that the driver can't be loaded,there is a problem.
> 
> My question is: What is the problem with the driver after 
> upgrading the 
> kernel?
> 
> I think somehow when red hat is installed with the first 
> kernel, there is 
> some aditional configuration with this particular driver that 
> is lost when 
> upgrading.
> 
> What do I need to reconfigure?
> 
> Thanks in advance.
> 
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
