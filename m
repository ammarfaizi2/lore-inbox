Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311569AbSCZNQA>; Tue, 26 Mar 2002 08:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311471AbSCZNPv>; Tue, 26 Mar 2002 08:15:51 -0500
Received: from mail-01.med.umich.edu ([141.214.93.149]:28167 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S311464AbSCZNPn> convert rfc822-to-8bit; Tue, 26 Mar 2002 08:15:43 -0500
Message-Id: <sca02e2c.038@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Tue, 26 Mar 2002 08:15:11 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <kschad@correo.e-technik.uni-ulm.de>, "<"<linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide
	load togeter with heavy network load
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got one system roughly similar to yours, RAID 5 , but scsi, not ata.
The CPU is also a 1400MHz Athlon. 
My lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100] (rev 25)
00:0a.0 SCSI storage controller: Adaptec 7899A (rev 01)
00:0a.1 SCSI storage controller: Adaptec 7899A (rev 01)
00:0b.0 SCSI storage controller: Adaptec AIC-7881U
00:0c.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 18)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF

It would hang exactly as you described. It's a test system, and things change so fast I never got around to tracking the problem down. However, it's now running 2.4.19-pre4 and hasn't hung for days (since 2.4.19-pre4 was installed).

Nik


>>> Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de> 03/26/02 06:27AM >>>
> Hi !

> I have problems with PC mainboard using the Via VT8367 [KT266] chipset.  
> lspci shows the configuration:
> lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
> 00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
> 01)00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
> (rev 01)00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)
>
>The CPU is a 1400MHz Athlon. 
> We use this system for a software Raid 5. If we produce heavy load on the 
> disks and network the system hangs. There is no log of errors at all. We 
> tried to change the network card form a 3com to a rtl83xx. The system remains 
> a litle longer stable but crashes then too. We also tried to have the 
> harddisks on seperate ide channels but this didn't solve the crashs. 
> It seems to be something with the dma, because if we disable the dma of the 
> harddisks the system is stable. Does anybody also recognise this problem ?
> Is there any solution for this effect ?
>
> Thanks a lot 
>
> Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

