Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTKUAAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTKUAAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:00:07 -0500
Received: from mail4.ssmb.com ([199.67.139.129]:63532 "EHLO
	imbaspam-ny04.iplex.ssmb.com") by vger.kernel.org with ESMTP
	id S263938AbTKUAAA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:00:00 -0500
content-class: urn:content-classes:message
Subject: sungem issues
Date: Thu, 20 Nov 2003 18:59:35 -0500
Message-ID: <D3365BA42AA4D611A5100008023D06D20556B563@exchny49.ny.ssmb.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT enable on BIOS which doesn't supports it?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6446.0
Thread-Index: AcOvwAkLgwwpo/GsTGOJK/Wf2K/FNQAAVX6Q
From: "Badinter, George" <george.badinter@citigroup.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4-22 on x86 with Sun GigE Card. The card seemed to
recognized fined and I see it come up. However,
it doesn't want to play nice with Cisco 3500XL switch. I have tried
several port setting on the switch's port i.e.
autoneg off/on duplex full/half and etc. I see link lights, ethtool says
that the link is up, but there is no traffic coming through.
This brings me to the interesting point, apparently sungem driver was
fixed from 2.4-19 to 2.4-22, however ethtool still
has no effect on it. No matter, how much I tried to play with it, it
will not change any settings on sungem interface. It comes
at 100 Full Duplex, autoneg on. 

Has anyone able to make this card work under 2.4-22??? Please help!!

Here some outputs:

lspci -vv

00:08.0 Ethernet controller: Sun Microsystems Computer Corp. GEM (rev
01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, non-prefetchable)
[size=2M]
        Expansion ROM at 40000000 [size=1M]
[root@luke root]# lsmod   
Module                  Size  Used by    Not tainted
autofs                 13748   0  (autoclean) (unused)
sungem                 27468   1 
3c59x                  30576   1 
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              16032   1  [iptable_filter]
mousedev                5624   0  (unused)
keybdev                 2912   0  (unused)
input                   6080   0  [mousedev keybdev]
hid                    12380   0  (unused)
usb-ohci               21896   0  (unused)
usbcore                80960   1  [hid usb-ohci]
ext3                   73124   3 
jbd                    56080   3  [ext3]
raid0                   3848   1 


[root@luke root]# ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:03:BA:16:26:55  
          inet addr:192.168.0.81  Bcast:192.168.0.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:4294967251
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:4294967281
          collisions:4294967266 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:16 Base address:0x5400 
[root@luke root]# ethtool eth1
Settings for eth1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Half 1000baseT/Full 
        Supports auto-negotiation: Yes
        Advertised link modes:  Not reported
        Advertised auto-negotiation: No
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: externel
        Auto-negotiation: on
        Current message level: 0x00000007 (7)
        Link detected: yes

Thanks again.

George
