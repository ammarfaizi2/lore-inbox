Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSG3NRI>; Tue, 30 Jul 2002 09:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSG3NRI>; Tue, 30 Jul 2002 09:17:08 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:25729 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S318255AbSG3NRI>;
	Tue, 30 Jul 2002 09:17:08 -0400
Date: Tue, 30 Jul 2002 16:20:27 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.29: oops in PnPBIOS init
Message-ID: <Pine.GSO.4.43.0207301605420.24326-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Digital Celebris GL 5133 ST (P5 133 MHz), BIOS 1.07 (the latest one).
Works fine in 2.4.19-pre* and 2.5.19 (incl. PNP BIOS). 2.5.29+BK as of
30.07.2002. PNPBIOS support compiled int, right after the message that
PNPBIOS was found happens the following oops. UP kernel, with migration
thread initialization fix as the only patch.

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5390
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x7330, dseg 0xf0000
general protection fault 0000
CPU:    0
EIP:    0060:[<00000004>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: 00020078   ecx: 00700078   edx: 00000000
esi: 00000246   edi: 00020078   ebp: c10cff84   esp: c10cff00
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00020078 00700078 00000000 c01bcd1a 00000010 00000082 00000000
       00000000 00000018 00000018 00000246 00020078 c10cff84 c10cff84 000000a0
       c02534f8 00000000 c10ce000 00000000 c01bcd8f c10cff84 c10cff84 c027af28
Call Trace: [<c01bcd1a>] [<c01bcd8f>] [<c0105083>] [<c01055f4>]
Code:  Bad EIP value.


>>EIP; 00000004 Before first symbol   <=====

>>ebx; 00020078 Before first symbol
>>ecx; 00700078 Before first symbol
>>edi; 00020078 Before first symbol
>>ebp; c10cff84 <_end+e01558/453a5d4>
>>esp; c10cff00 <_end+e014d4/453a5d4>

Trace; c01bcd1a <__pnp_bios_dev_node_info+d2/13c>
Trace; c01bcd8f <pnp_bios_dev_node_info+b/2c>
Trace; c0105083 <init+23/170>
Trace; c01055f4 <kernel_thread+28/38>

-- 
Meelis Roos (mroos@linux.ee)

