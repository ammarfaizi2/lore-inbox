Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSK0Po1>; Wed, 27 Nov 2002 10:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbSK0Po1>; Wed, 27 Nov 2002 10:44:27 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:13803 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262981AbSK0PoZ> convert rfc822-to-8bit; Wed, 27 Nov 2002 10:44:25 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.49 (-mm1): Some results with modules
Date: Wed, 27 Nov 2002 16:51:42 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211271651.42803.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.49-mm1 is somewhat unstable on my dual Athlon MP all SCSI main disk is 
U160 10k and ReiserFS 3.6 all the time.

Hang during dbench 32.

But several modules need fixing/update.

Module                  Size  Used by
af_packet              16000  1 [unsafe]
radeon                 97520  0
ipt_TCPMSS              2932  1 [unsafe]
ipt_TOS                 1504  22 [unsafe]
ipt_MASQUERADE          2168  2 [unsafe]
ipt_LOG                 3884  141 [unsafe]
ipt_state               1412  127 [unsafe]
ip_nat_ftp              3768  0
ip_conntrack_ftp        4680  2 ip_nat_ftp [unsafe]
evdev                   5768  0
pppoe                  11372  1 [unsafe]
pppox                   2580  2 pppoe [unsafe]
ppp_generic            24056  5 pppoe pppox [unsafe]
slhc                    5956  1 ppp_generic
e100                   57664  2
ipt_REJECT              3632  3 [unsafe]
iptable_mangle          2660  1 [unsafe]
iptable_nat            21308  4 ipt_MASQUERADE ip_nat_ftp [unsafe]
ip_conntrack           25996  8 ipt_MASQUERADE ipt_state ip_nat_ftp 
ip_conntrack_ftp iptabl
e_nat [unsafe]
iptable_filter          2260  1 [unsafe]
ip_tables              15004  20 ipt_TCPMSS ipt_TOS ipt_MASQUERADE ipt_LOG 
ipt_state ipt_RE
JECT iptable_mangle iptable_nat iptable_filter [unsafe]
psmouse                 5264  0
mousedev                5692  1
w83781d                21068  0
eeprom                  4840  0
i2c_isa                 1888  0


Module ip_tables cannot be unloaded due to unsafe usage in 
net/ipv4/netfilter/ip_tables.c:1385

ip_conntrack version 2.1 (8191 buckets, 65528 max) - 304 bytes per conntrack
Module ip_conntrack cannot be unloaded due to unsafe usage in 
net/ipv4/netfilter/ip_nat_standalone.c:318

Module iptable_filter cannot be unloaded due to unsafe usage in 
net/ipv4/netfilter/ip_tables.c:1120

Module ipt_REJECT cannot be unloaded due to unsafe usage in 
net/ipv4/netfilter/ip_tables.c:701

Saw underflow (231 of 255 bytes). Treated as error
Saw underflow (231 of 255 bytes). Treated as error
Saw underflow (231 of 255 bytes). Treated as error
Saw underflow (231 of 255 bytes). Treated as error
Saw underflow (231 of 255 bytes). Treated as error
Saw underflow (231 of 255 bytes). Treated as error

CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
Module pppox cannot be unloaded due to unsafe usage in drivers/net/pppox.c:50

fix old protocol handler +0x0/0x241c [pppoe]!
fix old protocol handler +0x0/0x241c [pppoe]!
fix old protocol handler +0x0/0x241c [pppoe]!

BTW Where can I get the latest module-init-tools (0.8) with which module 
"autoloading" goes, again?

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
