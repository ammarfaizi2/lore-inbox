Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTJ3WAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTJ3WAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:00:42 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:35821 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262868AbTJ3WAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:00:39 -0500
From: Richard van der Veen <richard_vd_veen@yahoo.com>
Reply-To: rysh@home.nl
To: linux-kernel@vger.kernel.org
Subject: Problem with de2104x networking module
Date: Thu, 30 Oct 2003 23:00:36 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310302300.36876.richard_vd_veen@yahoo.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a problem with the de2104x module for my Faralon network card. In 
2.4.xx version i could use the tulip driver for this card, but that doesn't 
work anymore for the 2.6.x kernel. So i had to use the de2104x module to get 
the network working. I can not find any error message in the logs though. 

Problem: The network dies when i use programs like tcpdump, snort and 
tethereal. After having used tcpdump, the ping program 'hangs' because it can 
not pump packets through the interface. (also all other networking programs 
don't work then anymore)

What works to get it working again is: 
ifconfig eth0 down
rmmod de2104x
modprobe de2104x 
/etc/init.d/networking restart

I use dhcp to get an ip 
	(i noticed this bug after i changed this interface to use dhcp)
i use Debian (unstable)

relevant lspci -v info for the nic:

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 21)
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9000 [size=128]
        Memory at de800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K

dmesg info:
Linux version 2.6.0-test9 (root@borg) (gcc version 3.3.2 (Debian)) #2 Thu Oct 
30 21:49:26 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
[...]
de2104x PCI Ethernet driver v0.6 (Sep 1, 2003)
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: 10baseT-HD
eth0: 21041 at 0xe0853000, 00:00:c5:0d:b0:19, IRQ 5
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0000, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto


As i wrote, i can not find any error message and don't know where to look or 
what to do to point to the exact problem. Nothing to find in /var/log/syslog 
or with the dmesg-program. I'm no programmer and just want to try/test the 
new kernel ... and hope my info can help to solve this problem. Thanx for 
reading. 


Gr.
Richard

