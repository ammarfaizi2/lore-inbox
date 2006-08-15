Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWHOPRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWHOPRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWHOPRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:17:19 -0400
Received: from mail.windriver.com ([147.11.1.11]:46828 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1030341AbWHOPRS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:17:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Unable to boot kernel after compiling source for 2.6.17-1.2157
Date: Tue, 15 Aug 2006 08:17:15 -0700
Message-ID: <238E9E8D08550342B3642CB0631EFFD42F8D9D@ala-mail04.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to boot kernel after compiling source for 2.6.17-1.2157
Thread-Index: AcbAere6AtrSIRXNTPqsqnsqbuiN0QAAKOKw
From: "Zeidler, Mike" <mike.zeidler@windriver.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After building the kernel  and copying the arch/i386/boot/bzImage to
/boot/vmlinuz-2.6.17-1.2157_FC5smp 
and doing a make modules_install 
and doing a mkinitrd
And modifying grub.conf to have the following lines

default=0
timeout=5
splashimage=(hd0,0)/grub/splash.xpm.gz
hiddenmenu
title Fedora Core (2.6.17-1.2157_FC5smp)
        root (hd0,0)
        kernel /vmlinuz-2.6.17-1.2157_FC5smp ro
root=/dev/VolGroup00/LogVol00 rhgb quiet
        initrd /initrd-2.6.17-1.2157_FC5smp.img

I am still getting the following errors:


Insmod : error inserting '/lib/scsi_mod.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/sd_mod.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/libata.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/satasil24.ko' : -1 Operation not
Permitted
Insmod : error inserting '/lib/ata_piix.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/jbd.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/ext3' : -1 Operation not Permitted
Insmod : error inserting '/lib/dm_mod.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/mirror.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/zero.ko' : -1 Operation not Permitted
Insmod : error inserting '/lib/snapshot.ko' : -1 Operation not Permitted

Any advice?

Mike
