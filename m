Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135614AbREBP50>; Wed, 2 May 2001 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbREBP5O>; Wed, 2 May 2001 11:57:14 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:59914 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S135618AbREBPza>; Wed, 2 May 2001 11:55:30 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDCA@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'andrewm@uow.edu.au'" <andrewm@uow.edu.au>
Cc: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [3com905b freeze Alpha SMP 2.4.2] FullDuplex issue ?
Date: Wed, 2 May 2001 17:55:12 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0D320.457E1940"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0D320.457E1940
Content-Type: text/plain;
	charset="iso-8859-1"

Hello,

********************************************************************
my hardware configuration is:

2 Alphaserver ES40 running kernel 2.4.2smp
   with 3com905b FastEthernet PCI 


The configuration is switched, 100 Full Duplex autonegotiation.
********************************************************************


I insert the 3c59x module with debug=7.


I start an ftp transfer from machine A to B:

	machine A			machine B	

	ftp B				ftpd answering

	get bigfile		

bigfile is 500 Megabytes, and transfer fine at 11 MegaBytes/s perfectly


Now I want to stress/test fullduplex:

	machine A			machine B
	
	ftp B				ftp A
	ftpd answers to B		ftpd answer to A
	get bigFile			get bigFile2

The first of the above machines launching the get freezes.	

I include a file with my logs, the output of the crashed machine after
reboot.
I also include the output of uname -a, lspci -vx, vortex --aaee.

Thanks for any help, If some information is missing there do not hesitate to
ask.


Sebastien Cabaniols


------_=_NextPart_000_01C0D320.457E1940
Content-Type: text/plain;
	name="log3Com.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log3Com.txt"



uname-a

Linux es40-06 2.4.2smp #1 SMP Wed May 2 13:58:01 EDT 2001 alpha unknown
=20



kernel log with debug=3D7 passed to modprobe




May  2 16:45:52 es40-06 kernel: 3c59x.c:LK1.1.12 06 Jan 2000  Donald =
Becker and others. http://www.scyld.com/network/vortex.html $Revision: =
1.102.2.46 $
May  2 16:45:52 es40-06 kernel: See Documentation/networking/vortex.txt
May  2 16:45:52 es40-06 kernel: eth0: 3Com PCI 3c905B Cyclone 100baseTx =
at 0x8400,  00:01:02:d9:94:f0, IRQ 32
May  2 16:45:52 es40-06 kernel:   product code 'CG' rev 00.12 date =
09-22-00
May  2 16:45:52 es40-06 kernel:   8K byte-wide RAM 5:3 Rx:Tx split, =
autoselect/Autonegotiate interface.
May  2 16:45:52 es40-06 kernel:   MII transceiver found at address 24, =
status 786d.
May  2 16:45:52 es40-06 kernel: 3c59x: Wake-on-LAN functions disabled
May  2 16:45:52 es40-06 kernel:   Enabling bus-master transmits and =
whole-frame receives.
May  2 16:46:07 es40-06 sysctl: error: 'net.ipv4.ip_always_defrag' is =
an unknown key
May  2 16:46:07 es40-06 sysctl: net.ipv4.ip_forward =3D 0
May  2 16:46:07 es40-06 sysctl: net.ipv4.conf.all.rp_filter =3D 1
May  2 16:46:07 es40-06 sysctl: kernel.sysrq =3D 0
May  2 16:46:07 es40-06 network: Setting network parameters:  succeeded
May  2 16:46:07 es40-06 ifup: SIOCADDRT: Network is unreachable
May  2 16:46:07 es40-06 network: Bringing up interface lo:  succeeded
May  2 16:46:07 es40-06 kernel: eth0: using NWAY autonegotiation
May  2 16:46:07 es40-06 kernel: eth0: MII #24 status 786d, link partner =
capability 41e1, setting full-duplex.
May  2 16:46:07 es40-06 network: Bringing up interface eth0:  succeeded
May  2 16:47:02 es40-06 ftpd[1225]: FTP LOGIN FROM es40-05.idris.domain =
[10.1.1.5], toto
May  2 16:47:29 es40-06 kernel: <74 ticks.
May  2 16:47:29 es40-06 kernel: <7tart_xmit()
May  2 16:47:29 es40-06 kernel: < e401.
May  2 16:47:29 es40-06 kernel: <77>eth0: exiting interrupt, status =
e000.
May  2 16:47:29 es40-06 kernel: t size 66 status 60008042.
May  2 16:47:29 es40-06 kernel: <nterrupt. status=3D0xe401
May  2 16:47:29 es40-06 kernel: <t()
May  2 16:47:29 es40-06 kernel: <<7>boomerang_rx(): status e001
May  2 16:47:29 es40-06 kernel:  interrupt loop, status e401.
May  2 16:47:29 es40-06 kernel: <7errupt, status e201, latency 3 ticks.
May  2 16:47:29 es40-06 kernel: <_xmit()
May  2 16:47:29 es40-06 kernel: <status e401.
May  2 16:47:29 es40-06 kernel: <rt_xmit()


next line is syslog restart after the freeze of the machine

lspci -vx

00:03.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX =
[Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 32
        I/O ports at 8400 [size=3D128]
        Memory at 000000000a0c3000 (32-bit, non-prefetchable) =
[size=3D128]
        Expansion ROM at 000000000a0a0000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 30 00 00 02 10 20 00 00
10: 01 84 00 00 00 30 0c 0a 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 0a 0a dc 00 00 00 00 00 00 00 20 01 0a 0a
vortex --aaee

 ./vortex -aaee
vortex-diag.c:v2.04 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0x8400.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0000 0000 f5f5 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 0000 0000 0000 0000 2000.
  Window 2: 0100 d902 1a93 0000 0000 0000 000a 4000.
  Window 3: 0000 0180 05ea 0020 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd8 0003 8880 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0900 1000 0252 0a87 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0x8400
  0x8410: **FIFO** 00000000 00000011 *STATUS*
  0x8420: 00000020 00000000 00080000 00000004
  0x8430: 00000000 234ddcb3 c1d88090 00080004
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: full-duplex.
 Station address set to 00:01:02:d9:93:1a.
 Configuration options 000a.
EEPROM contents (64 words, offset 0):
 0x000: 0001 02d9 931a 9055 0135 0048 4743 6d50
 0x008: 2971 0000 0001 02d9 931a 0010 0000 0022
 0x010: 32a2 0000 0000 0180 0000 0000 0000 10b7
 0x018: 9055 000a 0000 0000 0000 0000 0000 0000
 0x020: 0093 0000 0000 0000 0000 0000 0000 0000
 0x028: 0000 0000 0000 0000 0000 0000 0000 0000
 0x030: 0000 0000 0000 0000 0000 0000 0000 0000
 0x038: 0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0x71bb.
Parsing the EEPROM of a 3Com Vortex/Boomerang:
 3Com Node Address 00:01:02:D9:93:1A (used as a unique ID only).
 OEM Station address 00:01:02:D9:93:1A (used as the ethernet address).
 Manufacture date (MM/DD/YYYY) 9/21/2000, division H, product CG.
Options: none.
  Vortex format checksum is incorrect (00fb vs. 10b7).
  Cyclone format checksum is correct (0x93 vs. 0x93).
  Hurricane format checksum is correct (0x93 vs. 0x93).









------_=_NextPart_000_01C0D320.457E1940--
