Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbRFLSCf>; Tue, 12 Jun 2001 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbRFLSCZ>; Tue, 12 Jun 2001 14:02:25 -0400
Received: from ivy.tec.in.us ([168.91.1.1]:31629 "EHLO Otter.ivy.tec.in.us")
	by vger.kernel.org with ESMTP id <S262868AbRFLSCW>;
	Tue, 12 Jun 2001 14:02:22 -0400
From: John Madden <jmadden@ivy.tec.in.us>
Organization: Ivy Tech State College
To: linux-kernel@vger.kernel.org
Subject: 2.2.19: eepro100 and cmd_wait issues
Date: Tue, 12 Jun 2001 13:00:41 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01061109303910.16602@ycn013>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble on one machine out of about 20 that run with eepro100's. 
This one in particular happens to be a dual port.  I searched through the
archives for this, but I didn't find any definite solutions (one thread, on
"2.2.18 and laptop problems," provided a patch that doesn't seem to make any
difference).

After roughly 30 days of uptime, I get a lot of kernel messages like the
following:

kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!

I'd like to assume that this is bad hardware, but since the problem only
happens every 30 days or so (and every 30 days or so), I wanted to check here to
make sure it wasn't a driver issue.

The only solution I've found that works is to reboot, and since this is
probably the most production machine I'm responsible for (couldn't be any other
one, right?), I'd like to make sure I don't have to schedule a reboot every 29
days or something. :)

More info: 
Kernel 2.2.19 SMP, 
lspci: 
01:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Dual Port Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at fafff000 (32-bit, prefetchable)
        I/O ports at ece0
        Memory at fcf00000 (32-bit, non-prefetchable)
        Expansion ROM at fd000000 [disabled]
        Capabilities: [dc] Power Management version 1

01:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Dual Port Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at faffe000 (32-bit, prefetchable)
        I/O ports at ecc0
        Memory at fce00000 (32-bit, non-prefetchable)
        Expansion ROM at fd000000 [disabled]
        Capabilities: [dc] Power Management version 1

dmesg:
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <s
aw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15


Thanks!

John


-- 
John Madden
UNIX Systems Engineer
Ivy Tech State College
jmadden@ivy.tec.in.us
