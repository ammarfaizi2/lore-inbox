Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbRGVVSz>; Sun, 22 Jul 2001 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbRGVVSq>; Sun, 22 Jul 2001 17:18:46 -0400
Received: from www.sam-net.de ([212.118.203.2]:16146 "EHLO www.sam-net.de")
	by vger.kernel.org with ESMTP id <S268067AbRGVVSd>;
	Sun, 22 Jul 2001 17:18:33 -0400
Message-ID: <3B5B4329.2080101@kling-bauer.de>
Date: Sun, 22 Jul 2001 23:18:33 +0200
From: Dietmar Kling <d.kling@kling-bauer.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.2+) Gecko/20010719
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.7 and setpci no go
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

i have a problem with my new Athlon board and a really silly bios, which 
assigns
all my interrupts of usb,audio,eth0,bttv to irq 11

i have to turned off pnp aware OS in the bios
and i can set  via setpci the irq as the examples below indicate.

Still you can see in the example that the Line with the IRQ shows 11.
and when i insert for example the AC97 driver of ALSA io gets interrupt 11.

Same situation for usb, eth0, bttv.

So I am lost now :(
Is this a kernel bug or is there a kernel parameter which i have to use?

Regards
Dietmar


### Example 1 ####
/sbin/setpci  -v -s 00:11.5 INTERRUPT_LINE=9
00:11.5:3c 09
/sbin/lspci  -v -s 00:11.5 -x
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 10)
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Flags: medium devsel, IRQ 11
        I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
00: 06 11 59 30 01 00 10 02 10 00 01 04 00 00 00 00
10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 96 09
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 03 00 00
                                                                  ^^<--- 
changed
### Example 2  ####
/sbin/setpci  -v -s 00:11.5 INTERRUPT_LINE=0x0a
00:11.5:3c 0a
/sbin/lspci  -v -s 00:11.5 -x
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 10)
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Flags: medium devsel, IRQ 11
        I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
00: 06 11 59 30 01 00 10 02 10 00 01 04 00 00 00 00
10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 96 09
30: 00 00 00 00 c0 00 00 00 00 00 00 00 10 03 00 00
                                                                  ^^<--- 
changed                                                                   













