Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRAKQdd>; Thu, 11 Jan 2001 11:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbRAKQdY>; Thu, 11 Jan 2001 11:33:24 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:51718 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S132118AbRAKQdH>; Thu, 11 Jan 2001 11:33:07 -0500
From: dth@lin-gen.com (Danny ter Haar)
Subject: Re: Drivers under 2.4
Date: Thu, 11 Jan 2001 16:33:14 +0000 (UTC)
Organization: Linux Generation bv
Message-ID: <93kn8a$itt$1@voyager.cistron.net>
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <93k75v$r1u$1@voyager.cistron.net> <93ke9q$jnj$1@voyager.cistron.net> <3A5DC411.794486B0@mandrakesoft.com>
Reply-To: dth@lin-gen.com
X-Trace: voyager.cistron.net 979230794 19389 195.64.80.162 (11 Jan 2001 16:33:14 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>Does this patch help at all?


Nope, unfortunatly it didn't

> filename="pcnet32.patch"



pcnet32_probe_pci: found device 0x001022.0x002000 
    ioaddr=0x00fce0  resource_flags=0x000101
PCI: Found IRQ 9 for device 00:0f.0      
  PCnet chip version is 0x22625003.       
eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d<6>pcnet32: pcnet32_priv
ate lp=c3fb8d40 lp_dma_addr=0x3bf1000       
 assigned IRQ 9.                           
pcnet32.c:v1.25smp Nov 11, 2000 tsbogend@alpha.franken.de
eth0: pcnet32_open() irq 9 tx/rx rings 0x3bf1200/0x3bf1000 init 0x3bf1300.
eth0: pcnet32 open after 5 ticks, init block 0x3bf1300 csr0 01f3.
eth0: pcnet32_start_xmit() called, csr0 01f3.


multimedia:~# ping -c5 192.168.1.1
PING 192.168.1.1 (192.168.1.1): 56 data bytes
--- 192.168.1.1 ping statistics ---
5 packets transmitted, 0 packets received, 100% packet loss
multimedia:~# arp -an
? (192.168.1.2) at <incomplete> on eth0
? (192.168.1.1) at <incomplete> on eth0 

multimedia:~# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:00:E2:24:41:1D
          inet addr:192.168.1.51  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0 
          collisions:0 txqueuelen:100
          Interrupt:9 Base address:0xfce0 



Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
