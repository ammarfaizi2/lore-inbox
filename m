Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289759AbSAWKOE>; Wed, 23 Jan 2002 05:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSAWKNo>; Wed, 23 Jan 2002 05:13:44 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:54454 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289759AbSAWKNm>; Wed, 23 Jan 2002 05:13:42 -0500
From: "Roland Schwarz" <schw4702@uni-trier.de>
To: "Linux Kernel MailingListe" <linux-kernel@vger.kernel.org>,
        "Justin A" <justin@bouncybouncy.net>
Subject: AW: via-rhine timeouts
Date: Wed, 23 Jan 2002 11:12:37 +0100
Message-ID: <ENEMLHMAAMHHCIBOKBBCCEGLEKAA.schw4702@uni-trier.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020122234201.GA835@bouncybouncy.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there !

I have the same problems with an older gigabyte dual p2 mainboard an 3com
pci network cards, thread posted some days ago.
I have now mooved the network cards through the slots, the first time it
apeared only with ine card, now there are three cards in the machine and it
works fine.
I think it was a problem with the interrupt sharing in combination with some
heavier network load.

[cut from syslog]
Jan 17 10:18:20 highfidelity kernel: eth0: Interrupt posted but not
delivered -- IRQ blocked by another device?
Jan 17 10:18:20 highfidelity kernel:   Flags; bus-master 1, dirty
11892733(13) current 11892733(13)
Jan 17 10:18:20 highfidelity kernel:   Transmit list 00000000 vs. cf505540.
Jan 17 10:18:20 highfidelity kernel:   0: @cf505200  length 800000ff status
000100ff

[...continue until reboot or until bored]

so for the last days with "reorganized card arrangement" the systems run
really fine, and it is definitly under heavy load ..
( i'm mirroring some pages and transferring some gigabytes of files to
friends .. just for testing )
ifconfig gave me a thoughput of ~ 4 Gigabytes over three days, that looks
fine.
for the moment :-)

So, if your network card is mounted onboard, maybe you can play around with
the bios settings so change something ?

I hope, that can help you a little .


have fun & may the tux-force be with you !

blacky ( roland ... )




-----Ursprungliche Nachricht-----
Von: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]Im Auftrag von Justin A
Gesendet: Mittwoch, 23. Januar 2002 00:42
An: linux-kernel@vger.kernel.org
Betreff: via-rhine timeouts


I've been getting many errors due to timeouts, everything was fine while
I was at home, but here at school it's a major problem:

Jan 22 18:10:00 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:00 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY
status 782d, resetting...
Jan 22 18:10:10 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:10 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY
status 782d, resetting...
Jan 22 18:10:18 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:18 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY
status 782d, resetting...
Jan 22 18:10:26 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:26 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY
status 782d, resetting...
Jan 22 18:10:34 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:34 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY
status 782d, resetting...

Jan 22 18:10:34 bouncybouncy kernel: eth0: reset did not complete in 10
ms.

once it complains about that, it stops working until I reboot.

It seems to happen everytime a large transer is done.(apt-get updgrade
-d the last 3 times.)

Is this a problem with me, or are the hubs screwy?  The hubs I'm on are
"smart hubs", lets just say they aren't too bright:)

I have a soyo k7vdragon+ using 2.4.17:
eth0: VIA VT6102 Rhine-II at 0xe800, 00:50:2c:01:64:a9, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
0021.

CC replies...
-Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

