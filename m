Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279506AbRKDKTK>; Sun, 4 Nov 2001 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279547AbRKDKTB>; Sun, 4 Nov 2001 05:19:01 -0500
Received: from L0851P06.dipool.highway.telekom.at ([62.46.170.70]:22537 "EHLO
	tserver") by vger.kernel.org with ESMTP id <S279506AbRKDKSr>;
	Sun, 4 Nov 2001 05:18:47 -0500
Message-ID: <004901c1651a$155128c0$0200a8c0@piii450>
Reply-To: "Tom Winkler" <tiger@tserver.2y.net>
From: "Tom Winkler" <tiger@tserver.2y.net>
To: <linux-kernel@vger.kernel.org>
Subject: Vaio IRQ routing / USB problem
Date: Sun, 4 Nov 2001 11:18:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've run into problems while getting Linux running on my
new Sony Vaio FX403 with an Intel i815EM / i820 (Comino 2)
chipset (see appended output of lspci -v for more information).
When including USB support into the kernel (usb-uhci) i get
error messages like this in /var/log/syslog

hub.c: USB new device connect on bus1/2, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

I tried with Kernel 2.4.13, 2.4.13ac6 and ac7 as well as
2.4.14pre7 and pre8. It's always the same. Johannes Erdfelt
from linux-usb.org told me the following:

"It's not a USB problem, it's a PCI IRQ routing problem. You should
check with the PCI people on linux-kernel [...]."

Nevertheless there is a trick to get USB devices recognized and workig:
If I plug in my mouse while running KDE and playing sounds over the aRts
soundserver my mouse gets detected when pluged into the USB port.
When i stop playing sound the mouse stops working after some time (about
1 minute).

As far as I was able to find out I'm not the only one having these
problems on Vaio laptops. J. Ziuber and some others seem to have pretty
much the same problems (still unsolved as they told me). You can find
a very detailed posting from J. Ziuber over at
http://groups.google.com/groups?q=820+usb+linux&hl=en&lr=lang_en|lang_de&rn
um=2&selm=fa.jc3v49v.g76bbr%40ifi.uio.no

Furhtermore i noticed the following 2 lines when looking at the output of
dmesg (full output of dmesg is appended below):

PCI: Found IRQ 10 for device 00:1f.2
IRQ routing conflict for 00:1f.2, have irq 9, want irq 10

According to lspci 00:1f.2 is USB HUB A. I'm not really sure what i can
do about this problem (not sure if that might have something to do with
it but turning pnp os on/off in the bios has no effect).

I now wanted to ask if this problem is known to you and if you think that
this can/will be solved sometimes in the near future. If you need testers
for any patches on that subject you can count me in, of course.

I'd be glad if you could share your thoughts about that problem with me
since I'm thinking about returning this laptop to the local dealer. It's
not much fun working without usb and therefore without external input
devices all the time since there are no PS2 ports. And Windows (where USB
works perfectly) isn't really an option for me.

Thanks in advance for your help,
 Tom Winkler


APPENDIX

 Since I din't want to blow all your mailboxes with proberbly useless
 stuff I decided to put the output of lspci -v and dmesg on my webserver
 to make it available for those who need it to help me with my problems:

 lspci -v  http://www.sbox.tugraz.at/home/t/twinkler/vaio/lspciv.txt
 dmesg     http://www.sbox.tugraz.at/home/t/twinkler/vaio/dmesg.txt

