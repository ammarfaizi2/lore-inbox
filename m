Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRAKL7S>; Thu, 11 Jan 2001 06:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRAKL7I>; Thu, 11 Jan 2001 06:59:08 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:21265 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129324AbRAKL6u>; Thu, 11 Jan 2001 06:58:50 -0500
From: dth@lin-gen.com (Danny ter Haar)
Subject: Re: Drivers under 2.4
Date: Thu, 11 Jan 2001 11:58:55 +0000 (UTC)
Organization: Linux Generation bv
Message-ID: <93k75v$r1u$1@voyager.cistron.net>
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <+0100> <20010111115833.A27971@lin-gen.com> <3A5D9AB1.39F6627C@uow.edu.au>
Reply-To: dth@lin-gen.com
X-Trace: voyager.cistron.net 979214335 27710 195.64.80.162 (11 Jan 2001 11:58:55 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <andrewm@uow.edu.au> wrote:
>There's a "reporting problems" section at the end
>of Documentation/networking/vortex.txt.  Should help.

okidoki, have read it, thanks

>Probably the most important thing is inserting the driver
>module with `debug=7', opening the device, sending some
>traffic and then sending us the logs.


pcnet32_probe_pci: found device 0x001022.0x002000
    ioaddr=0x00fce0  resource_flags=0x000101
PCI: Found IRQ 9 for device 00:0f.0
  PCnet chip version is 0x22625003.
eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d
pcnet32: pcnet32_private lp=c3bf6000 lp_dma_addr=0x3bf6000 assigned IRQ 9.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
eth0: pcnet32_open() irq 9 tx/rx rings 0x3bf6200/0x3bf6000 init 0x3bf6300.
eth0: pcnet32 open after 5 ticks, init block 0x3bf6300 csr0 01f3.
eth0: pcnet32_start_xmit() called, csr0 01f3.                                  

this after bootup, static ip adress

multimedia:~# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:00:E2:24:41:1D
inet addr:192.168.1.51  Bcast:192.168.1.255  Mask:255.255.255.0
UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:100
Interrupt:9 Base address:0xfce0


multimedia:~# ping -c10 192.168.1.1
PING 192.168.1.1 (192.168.1.1): 56 data bytes
--- 192.168.1.1 ping statistics ---                                             
10 packets transmitted, 0 packets received, 100% packet loss                   

after this the following messages in dmesg:

Jan 11 12:45:49 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
Jan 11 12:46:01 multimedia last message repeated 12 times

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
