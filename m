Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293009AbSBVVth>; Fri, 22 Feb 2002 16:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293011AbSBVVtU>; Fri, 22 Feb 2002 16:49:20 -0500
Received: from casbah.gatech.edu ([130.207.165.18]:2261 "EHLO
	casbah.gatech.edu") by vger.kernel.org with ESMTP
	id <S293009AbSBVVtF>; Fri, 22 Feb 2002 16:49:05 -0500
Subject: Re: more detailed information about the AMD 1.6+ GHz MP smp-problem
From: Rob Myers <rob.myers@gtri.gatech.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mw@suk.net, linux-kernel@vger.kernel.org
In-Reply-To: <E16dtT5-0006wD-00@the-village.bc.nu>
In-Reply-To: <E16dtT5-0006wD-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 16:49:24 -0500
Message-Id: <1014414565.1231.263.camel@ransom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-21 at 08:41, Alan Cox wrote:
> > if anyone knows what bios settings and kernel bits make this board
> > stable please pass that info along...
> 
> MP table on 
> MP table version 1.1
> 
> You want 2.4.18-rc2 in order to get the fixups for what appears to be a BIOS
> PCI compliance config problem. You also may need to remove any 3com gige
> cards using broadcom chipsets.

ah thank you, those settings work nicely.  turns out i had a bad
motherboard.  the new one seems rock solid (after one day).  redhat 7.2
kernels 2.4.7-10 and 2.4.9-21 worked for me, as does 2.4.18-rc4.  

so if anyone else is having trouble with an asus a7m266d *with the
proper bios settings*, its possible (likely?) you've got a bad
motherboard.

rob.

ps- for the record my stable configuration includes 2 AMD Athlon(TM) XP
1900+, matrox g200, intel eepro100, hdd, and floppy.

[root@localhost root]# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c
(rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440
(rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441
(rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev
03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448
(rev 04)
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01)
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
02:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)


