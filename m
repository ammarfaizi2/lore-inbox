Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135639AbREFMeJ>; Sun, 6 May 2001 08:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135652AbREFMd6>; Sun, 6 May 2001 08:33:58 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:27407 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S135639AbREFMdu>; Sun, 6 May 2001 08:33:50 -0400
Message-ID: <000901c0d628$cd521b40$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010506130303.20add56a.ignaciomonge@navegalia.com> <20010506135139.5fccf928.ignaciomonge@navegalia.com>
Subject: Re: 8139too bug in 2.4.4 (2.4.3?) & VIA 686a
Date: Sun, 6 May 2001 16:33:49 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same bug in latest driver. And disabling MMIO didn't help...

----- Original Message -----
From: "Ignacio Monge" <ignaciomonge@navegalia.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 06, 2001 9:51 PM
Subject: Re: 8139too bug in 2.4.4 (2.4.3?) & VIA 686a


> En Sun, 6 May 2001 13:03:03 -0400
> Ignacio Monge <ignaciomonge@navegalia.com> escribió:
>
> >
> > I've compiled 2.4.3mdk-25 source with Athlon optimizations, and the
> > problem still happens.
> >
> > eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF
> >           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
> >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:4294967221 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:100
> >           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> >           Interrupt:11 Base address:0x9000
> >
> > Look at the HWaddr. With default kernel (not compiled), I haven't this
> > problem and my ethernet card goes well and the HWaddr is: ·"HWaddr
> > 00:E0:29:9A:CB:62 ". And I'm sure after reboot I *MUST* restore all the
> > values of my BIOS setup. Believe me,  I know. :(
> >
> >
> > Here is the output of dmesg when loading the 81389too module:
> >
> > Assertion failed! ioaddr != NULL,8139too.c,rtl8139_init_one,line=927
> > eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0x9000,
> > ff:ff:ff:ff:ff:ff, IRQ 11
> > eth0:  Identified 8139 chip type 'RTL-8139C'
> > eth0: Setting 100mbps half-duplex based on auto-negotiated partner
> > ability
> > ffff.
> >
> > "Assertion failed! ioaddr != NULL,8139too.c,rtl8139_init_one,line=927"?
> > What is this? Is this the cause of the bug?
> >
> > Now the lspci -vv:
> >
> > 00:0c.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
> > (rev 10)
> > Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
> > Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B-
> > Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort-
> > <MAbort- >SERR- <PERR-
> > Latency: 32 (8000ns min, 16000ns max)
> > Interrupt: pin A routed to IRQ 11
> > Region 0: I/O ports at 9000 [size=256]
> > Region 1: Memory at da800000 (32-bit, non-prefetchable) [size=256]
> > Expansion ROM at <unassigned> [disabled] [size=64K]
> > Capabilities: [50] Power Management version 2
> > Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > I hope these lines can help.
>
>
> ADDON:
>
> Dmesg:
> [...
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx queue start entry 4  dirty entry 0.
> eth0:  Tx descriptor 0 is ffffffff. (queue head)
> eth0:  Tx descriptor 1 is ffffffff.
> eth0:  Tx descriptor 2 is ffffffff.
> eth0:  Tx descriptor 3 is ffffffff.
> eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
> ffff.
> probable hardware bug: clock timer configuration lost - probably a VIA686a
> motherboard.
> probable hardware bug: restoring chip configuration.
>
> ...]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

