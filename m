Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJ3QE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJ3QE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:04:57 -0500
Received: from web10504.mail.yahoo.com ([216.136.130.154]:61584 "HELO
	web10504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262609AbTJ3QEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:04:53 -0500
Message-ID: <20031030160452.49444.qmail@web10504.mail.yahoo.com>
Date: Thu, 30 Oct 2003 08:04:52 -0800 (PST)
From: Kothi Raja <kothi_raja@yahoo.com>
Subject: PCI: Failed to allocate resource 6(df000000-deffffff)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting these errors with kernel 2.4.22 while it's
trying to set up a PCI Sun QFE card. 
My hardware consists of:
MB: Rioworks SDVIA-100 (VIA Apollo Pro 694 + 686B)
Processor: Single P3 933
Memory: 256MB SDRAM.
Matrox Millenium PCI 4MB RAM.
Sun QFE PCI 4 Port Fast Ethernet.

I'm running a self-built kernel 2.4.22 compiled using
GCC 3.3.2.

The first ethernet port gets initialized correctly but
the subsequent ones report this error. When I try to 
ifconfig eth1 add 192.168.1.111 netmask 255.255.255.0
I get:
SIOCSIFNETMASK: Cannot assign requested address

Here's the relevent portion of the system log.

Oct 31 09:40:09 alexa2 kernel: sunhme.c:v2.01
26/Mar/2002 David S. Miller (davem@redhat.com)
Oct 31 09:40:09 alexa2 kernel: divert: allocating
divert_blk for eth0
Oct 31 09:40:09 alexa2 kernel: eth0-3: Quattro HME
(PCI/CheerIO) 10/100baseT Ethernet DEC 21153 PCI
Bridge
Oct 31 09:40:09 alexa2 kernel: eth0: Quattro HME slot
0 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:ce:74:75

Oct 31 09:40:09 alexa2 kernel: PCI: Failed to allocate
resource 6(df000000-deffffff) for 02:01.1
Oct 31 09:40:09 alexa2 kernel: divert: allocating
divert_blk for eth1
Oct 31 09:40:09 alexa2 kernel: eth1: Quattro HME slot
1 (PCI/CheerIO) 10/100baseT Ethernet 22:6e:ad:00:00:00

Oct 31 09:40:09 alexa2 kernel: PCI: Failed to allocate
resource 6(df000000-deffffff) for 02:02.1
Oct 31 09:40:09 alexa2 kernel: divert: allocating
divert_blk for eth2
Oct 31 09:40:09 alexa2 kernel: eth2: Quattro HME slot
2 (PCI/CheerIO) 10/100baseT Ethernet a7:5f:10:00:00:00

Oct 31 09:40:09 alexa2 kernel: PCI: Failed to allocate
resource 6(df000000-deffffff) for 02:03.1
Oct 31 09:40:09 alexa2 kernel: divert: allocating
divert_blk for eth3
Oct 31 09:40:09 alexa2 kernel: eth3: Quattro HME slot
3 (PCI/CheerIO) 10/100baseT Ethernet ea:1d:02:00:00:00

Does anyone have an idea what the issue might be?
I will post the complete system log and any other info
if required.

Thanks in advance,
Krishna.


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
