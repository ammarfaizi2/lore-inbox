Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTLFLhO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTLFLgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:36:01 -0500
Received: from line-D-83.dynamic-athome.inode.at ([81.223.98.83]:29838 "EHLO
	martin.kleinerdrache.org") by vger.kernel.org with ESMTP
	id S265081AbTLFLfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:35:19 -0500
Date: Sat, 6 Dec 2003 12:35:07 +0100
From: Martin Klaffenboeck <martin.klaffenboeck@inode.at>
To: linux-kernel@vger.kernel.org
Subject: bttv BUG?
Message-ID: <20031206113507.GI4321@martin.kleinerdrache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get my pinnacle pctv rave card working.  It works, but I  
cannot get any signal, but I think, the cable is ok.  I think the  
kernel output should help me...

martin root # uname -a
Linux martin.kleinerdrache.org 2.6.0-test11-gentoo-r1 #4 SMP Fri Dec 5  
13:57:02 CET 2003 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux



When I load the bttv (via modprobe) I get the dmesg output:

bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 4, latency: 64, mmio:  
0xcddfe000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,insmod option]
tda9887: chip found @ 0x86
registering 1-0043
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=1 info="PAL / mono" radio=no
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found @ 0xc0
tuner: type set to 33 (MT2032 universal)
MT2032: Companycode=3cbf Part=42 Revision=40
MT2032 hexdump:
 42 40 20 c1 00 18 f4 77  29 04 85 04 88 60 f0 05
  24 3c bf 42 40
 not a MT2032.
registering 1-0060
MT2032: Companycode=3cbf Part=42 Revision=40
MT2032 hexdump:
 42 40 20 c1 00 18 f4 77  29 04 85 04 88 60 f0 05
  24 3c bf 42 40
 not a MT2032.
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok

Then I use tvtime to scan some stations.  (Its the same with scantv  
from xawtv).

I get from dmesg:

bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
bttv0: skipped frame. no signal? high irq latency?
tuner: tv freq set to 273.25
mt2032_set_if_freq rfin=273250000 if1=1090000000 if2=38900000  
from=32900000 to=39900000
mt2032: rfin=273250000 lo1=260 lo1n=32 lo1a=4 sel=4, lo1freq=1365000000
mt2032: rfin=273250000 lo2=200 lo2n=25 lo2a=0 num=2052  
lo2freq=1052850000
spurcheck f1=1365000 f2=1052850  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-740700
 spurtest n1=1 n2=-3 ftest=-1793550
 spurtest n1=1 n2=-4 ftest=-2846400
 spurtest n1=1 n2=-5 ftest=-3899250
 spurtest n1=2 n2=-3 ftest=-428550
 spurtest n1=2 n2=-4 ftest=-1481400
 spurtest n1=2 n2=-5 ftest=-2534250
 spurtest n1=3 n2=-4 ftest=-116400
 spurtest n1=3 n2=-5 ftest=-1169250
 spurtest n1=4 n2=-5 ftest=195750
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.F=0x05
mt2032: re-init PLLs by LINT
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.E=0xf0
mt2032: pll wait 1ms for lock (0xf0)
mt2032 Reg.F=0x05
mt2032: re-init PLLs by LINT
MT2032 Fatal Error: PLLs didn't lock.

And I get many of this.  My /var/log/everything/current (on gentoo, its
/var/log/messages on other distributions) tells me:

Dec  6 12:30:00 [kernel] tuner: tv freq set to 259.25
Dec  6 12:30:00 [kernel] bttv0: skipped frame. no signal? high irq  
latency?
                - Last output repeated 3 times -
Dec  6 12:30:01 [kernel] tuner: tv freq set to 266.25
Dec  6 12:30:01 [kernel] bttv0: skipped frame. no signal? high irq  
latency?
                - Last output repeated 2 times -


what does this irq latency mean? together with:

martin root # cat /proc/interrupts
           CPU0
  0:    1939804          XT-PIC  timer
  1:       5113          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         57          XT-PIC  eth1
  4:       1520          XT-PIC  bttv0
  8:      26331          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     122486          XT-PIC  SiS SI7012, eth0
 11:     146484          XT-PIC  nvidia
 12:     175303          XT-PIC  i8042
 14:     165696          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0
LOC:    1939802
ERR:       2655
MIS:          0

I cannot understand this message.

Maybe you can help me out?  Please tell me if you need more  
information.

Thanks,
Martin
