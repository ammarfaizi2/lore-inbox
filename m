Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbSJBJoI>; Wed, 2 Oct 2002 05:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbSJBJoI>; Wed, 2 Oct 2002 05:44:08 -0400
Received: from rammstein.mweb.co.za ([196.2.53.175]:59869 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S263022AbSJBJoG>; Wed, 2 Oct 2002 05:44:06 -0400
To: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: ide-scsi ooops with 2.5.40 (PIIX4 and DVD)
Date: Wed, 2 Oct 2002 09:49:23 GMT
X-Posting-IP: 196.34.86.10 via 172.24.158.16
X-Mailer: Endymion MailMan  
Message-Id: <E17wfyp-00063r-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> From dmesg:
> 
> ---
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebu> s=xx
> PIIX4: IDE controller at PCI slot 00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
> Debug: sleeping function called from illegal context at slab.c:1374
> d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d483c c03d4874
c03d483c>  
>        d7fdde6c c01ec775 d7ff6b2c 000001d0 0000e307 c03d4888 00000000
0> 0000206 
>        00000042 00000000 00000042 c03d483c c03d482c c03d4780 d7fddeb4
c> 01ec81a 
> Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>]
[<c01fe> 289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>]
> [<c020fdfe>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
> hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> Debug: sleeping function called from illegal context at slab.c:1374
^^^^^^^^^^^^^^

It's actually not an Ooops it is some debug code to capture code
which is doing the wrong thing. Dont worry about it.

> d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d4df8 c03d4e30
c03d4df8>  
>        d7fdde6c c01ec775 d7ff6b2c 000001d0 000000b0 c03d4e44 00000000
0> 0000202 
>        00000042 00000000 00000042 c03d4df8 c03d4de8 c03d4d3c d7fddeb4
c> 01ec81a 
> Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>]
[<c01fe> 289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>]
> [<c020fe1d>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> scsi_eh_offline_sdevs: Device set offline - notready or command retry
f> ailedafter error recovery: host0 channel 0 id 0 lun 0
^^^^^^^^^^^^^^

This is what I am worried about, I also saw this at my home PC, but
doing cdrecord -scanbus does pick up my cdwiter.

BTW: Thanx to whoever fixed ide-scsi I can now boot without getting an
Oops (that I reported in 2.5.39). Now I seem to have lost the mouse
but I will look ate that when I get back home.

Cheers



---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


