Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSEaPfH>; Fri, 31 May 2002 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSEaPfG>; Fri, 31 May 2002 11:35:06 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:199 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S315379AbSEaPfF>; Fri, 31 May 2002 11:35:05 -0400
Message-ID: <3CF7981D.7B70609F@eed.ericsson.se>
Date: Fri, 31 May 2002 17:34:53 +0200
From: "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
Organization: Ericsson EuroLab
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3c59x driver: card not responding after a while
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having (reproducable) problems with the 3c59x driver; after a while
(depends on card/traffic), the card doesn't send nor receive anymore.

I had 3c905B and 3c905C series, both affected. I did also change
mainboard-slots.
My current card is identifying as:
00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e800 [size=128]
        Memory at ed000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ec000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

Kernels were
o RH 7.2 stock (2.4.7)
o 2.4.17 (custom, driver builtin) (after a while)
o 2.4.18 (custom, driver builtin) (depending on traffic, last time:
[ifconfig output after the device is frozen]
          RX packets:249782 errors:0 dropped:0 overruns:94 frame:0
          TX packets:32712 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:49988234 (47.6 Mb)  TX bytes:8716361 (8.3 Mb)

2.2.19 worked fine.
gcc -v is gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98) (std
from RH 7.2; no 'kgcc' available)
I saw no changes in 2.4.19*, so I went out asking you :)

Machine is a K6-2 500 via a VIA MVP3 chipset, Shuttle mainboard (if that
matters).

If you do a /etc/init.d/network restart (or ifconfig eth0 down ;
ifconfig eth0 ... up), the card works again.
dmesg is not reporting anything.
I also did force the card to using fixed 100BaseTx-FD, didn't change
anything.

If you need further information or more testing please say so.
Please also include me on CC.
Thanks.
-- 
Ronny T. Lampert		email: Ronny.Lampert@eed.ericsson.se
System Administrator		voice: +49 911 255 1214
Ericsson Eurolab Deutschland	fax:   +49 911 255 1960
Nuernberg, Germany
