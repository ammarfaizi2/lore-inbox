Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284704AbRLMSqU>; Thu, 13 Dec 2001 13:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284787AbRLMSqK>; Thu, 13 Dec 2001 13:46:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:19827 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284704AbRLMSqD>;
	Thu, 13 Dec 2001 13:46:03 -0500
Date: Thu, 13 Dec 2001 19:45:55 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org, hfhsu@sis.com.tw, lcchang@sis.com.tw
Subject: Re: Disappointing SiS900 performance - driver issue?
Message-Id: <20011213194555.50d6adeb.rene.rebe@gmx.net>
In-Reply-To: <20011213102423.B13809@vitelus.com>
In-Reply-To: <20011213102423.B13809@vitelus.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My sis630 (incl. the sis900) bases Celeron-633 laptop is much faster (using
a 2.4.16 kernel here):

portable:~ # ./netio 192.168.1.1

NETIO - Network Throughput Benchmark, Version 1.13
(C) 1997-2001 Kai Uwe Rommel

TCP/IP connection established.
Packet size  1 k bytes:   10259 k bytes/sec
Packet size  2 k bytes:   10146 k bytes/sec
Packet size  4 k bytes:   10288 k bytes/sec
Packet size  8 k bytes:   10317 k bytes/sec
Packet size 16 k bytes:   10248 k bytes/sec
Packet size 32 k bytes:   10173 k bytes/sec

This the sis900 one as a client over a hub and a switch to a 3c59x - and
the other way round:

server1:~ # ./netio 192.168.1.5

NETIO - Network Throughput Benchmark, Version 1.13
(C) 1997-2001 Kai Uwe Rommel

TCP/IP connection established.
Packet size  1 k bytes:   8126 k bytes/sec
Packet size  2 k bytes:   8191 k bytes/sec
Packet size  4 k bytes:   8110 k bytes/sec
Packet size  8 k bytes:   8135 k bytes/sec
Packet size 16 k bytes:   8154 k bytes/sec
Packet size 32 k bytes:   8125 k bytes/sec

On Thu, 13 Dec 2001 10:24:23 -0800
Aaron Lehmann <aaronl@vitelus.com> wrote:

> My new motherboard has an onboard SiS900 ethernet device. I was hoping
> to free up a PCI slot by switching from my Intel EEPro100 to it. With
> the Intel card I can quite easilly pull 11.5mb/s, but the SiS seems to
> max out at 3.5mb/s or so. Is this the fault of the hardware or the
> driver?
> 
> sis900.c: v1.08.01  9/25/2001
> PCI: Assigned IRQ 11 for device 00:03.0
> eth0: Realtek RTL8201 PHY transceiver found at address 1.
> eth0: Using transceiver found at address 1 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 11, 00:d0:09:ea:ea:7e.
> ...
> eth0: Media Link On 100mbps full-duplex 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
