Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTALR6l>; Sun, 12 Jan 2003 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbTALR6l>; Sun, 12 Jan 2003 12:58:41 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55784 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267376AbTALR6h>; Sun, 12 Jan 2003 12:58:37 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
Subject: Linux 2.4.21-pre3-ac4
To: linux-kernel@vger.kernel.org
Date: Sun, 12 Jan 2003 13:07:26 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various compile fixes, and the next stage of IDE updating. In particular
the PIIX driver has been subjected to a full review of Intel chipset
errata. I've also added the framework to fix the problems Ross Biro found
but not yet enabled its use. Once enabled that should fix a lot of the
problems with shared IRQ IDE. Handle with care as usual.

Linux 2.4.21pre3-ac4
o	Finish verifying PIIX/ICH drivers versus errata	(me)
o	Fix handling of DMA0 MWDMA on early ICH		(me)
o	Fix compile in kernel for Aurora SIO16		(Adrian Bunk)
o	Clean up various Configure.help bits		(Adrian Bunk)
o	Disallow write combining on 450NX		(me)
o	Ensure rev C0 450NX has restreaming off		(me)
o	Don't do IDE DMA on rev B0 450NX or later	(me)
	450NX without BIOS workarounds for the hang
o	Update Configure.help for HPT IDE		(Adrian Bunk)
o	Fix harmless code error in sb_mixer		(Jeff Garzik)
o	Fix ethernet padding on via-rhine		(Roger Luethi)
o	Add ndelay functionality for x86		(me)
	| Based on Ross Biro's code
o	Add ide_execute_command 			(me)
	| Again based on Ross Biro's changed. Not yet used
	| This will be the new correct way to kick off an 
	| IDE command from non IRQ context
o	Matroxfb compile fix for one option combination	(Petr Vandrovec)

Linux 2.4.21pre3-ac3
o	Address comments on wcache value/issuing	(me)
	cache flush requests
o	Update credits entry for Stelian Pop		(Stelian Pop)
o	Backport some sonypi improvements from 2.5	(Kunihiko IMAI)
o	Fix pdcraid/silraid symbol clash		(Arjan van de Ven)
o	Fix ehci build with older gcc			(Greg Kroah-Hartmann)
o	Fix via 8233/5 hang				(me)
o	Fix non SMP cpufreq build			(Eyal Lebidinsky)
o	Fix sbp2 build with some config options		(Eyal Lebidinsky)
o	Fix ATM build bugs				(Francois Romieu)
o	Fix an ipc/sem.c race				(Bernhard Kaindl)
o	Fix toshiba keyboard double release		(Unknown)
o	CPUFreq updaes/fixes				(Dominik Brodowski)
o	Natsemi Geode/Cyrix MediaGX cpufreq support	(Hiroshi Miura,
							 Zwane Mwaikambo)
o	Add frequency table helpers to CPUfreq		(Dominik Brodowski)

Linux 2.4.21pre3-ac2
o	Fix the dumb bug in skb_pad			(Dave Miller)
o	Confirm some sparc bits are wrong and drop them	(Dave Miller)
o	Remove a wrong additional copyright comment	(Dave Miller)
o	Upgrade IPMI driver to v16			(Corey Minyard)
o	Fix 3c523 compile				(Francois Romieu)
o	Handle newer rpm where -ta is rpmbuild not rpm	(me)
o	Driver for Aurora Sio16 PCI adapter series	(Joachim Martillo)
	(SIO8000P, 16000P, and CPCI)
	| Initial merge
o	Backport Hammer 32bit mtrr/nmi changes		(Andi Kleen)
o	Add the fast IRQ path to via 8233/5 audio	(me)

Linux 2.4.21pre3-ac1
+	Handle battery quirk on the Vaio Z600-RE	(Paul Mitcheson)
*	EHCI USB updates				(David Brownell)
+	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
+	NVIDIA nForce2 IDE PCI identifiers		(Johannes Deisenhofer,
							 Tim Krieglstein)
*	CPU bitmask truncation fix			(Bjorn Helgaas)
o	HP100 cleanup					(Pavel Machek)
o	Fix initial capslock handling on USB keyboard	(Pete Zaitcev)
+	Update dscc4 driver for new wan			(Francois Romieu)
+	Fix boot on Chaintech 4BEA/4BEA-R and		(Alexander Achenbach)
	Gigabyte 9EJL by handing wacky E820 memory
	reporting
o	SysKonnect driver updates			(Mirko Lindner)
o	Fix memory leak in n_hdlc			(Paul Fulghum)
o	Fix missing mtd dependancy			(Herbert Xu)
+	Clean up ide-tape printk stuff			(Pete Zaitcev)
+	IDE tape fixes					(Pete Zaitcev)
o	Fix size reporting of large disks in scsi	(Andries Brouwer)
+	Fix excessive stack usage in NMI handlers	(Mikael Pettersson)
+	Add support for Epson 785EPX USB printer pcmcia	(Khalid Aziz)
*	Quirk handler to sort out IDE compatibility	(Ivan Kokshaysky)
	mishandling
+	Model 1 is valid for PIV in MP table		(Egenera)
+	Ethernet padding fixes for various drivers	(me)
o	Allow trident codec setup to time out		(Ian Soboroff)
	This can happen with non PM codecs
o	Fix broken documentation link			(Henning Meier-Geinitz)
o	Update video4linux docbook			(William Stimson)
o	Correct kmalloc check in dpt_i2o		(Pablo Menichini)
o	Shrink kmap area to required space only		(Manfred Spraul)
o	Fix irq balancing				(Ben LaHaise)
o	CPUfreq updates					(Dominik Brodowski)
o	Fix typo in pmagb fb				(John Bradford)
o	EDD backport					(Matt Domsch)


REMOVED FOR NOW

-	RMAP

REMOVED FOR GOOD

-	LLC 	(See 2.5)
-	VaryIO  (Never accepted mainstream)
