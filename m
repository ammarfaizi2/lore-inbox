Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271962AbRH2NSM>; Wed, 29 Aug 2001 09:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271964AbRH2NSD>; Wed, 29 Aug 2001 09:18:03 -0400
Received: from erm1.u-strasbg.fr ([130.79.74.61]:23815 "HELO erm1.u-strasbg.fr")
	by vger.kernel.org with SMTP id <S271962AbRH2NRr>;
	Wed, 29 Aug 2001 09:17:47 -0400
Date: Wed, 29 Aug 2001 15:29:25 +0200
To: linux-kernel@vger.kernel.org
Subject: [AMD] 79c970 ethernet card problems.....
Message-ID: <20010829152925.H1357@erm1.u-strasbg.fr>
Mail-Followup-To: bboett@erm1.u-strasbg.fr,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: bboett@erm1.u-strasbg.fr (Bruno Boettcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!
my motherboard assigns it IRQ without any distinction, i have several
cards on the same interrupt, e.g. the 2 ethernet cards are on irq 10 at
the moment .... so maybe this is the real problem ... anyways i have:
lspci:
00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 02)
  Flags: stepping, medium devsel, IRQ 10
  I/O ports at e000 [size=32]

/etc/modutils/network:
options lance io=0xe000 irq=10
alias eth1 lance  irq=10

in /var/log/messages:
Aug 29 12:25:16 kalman kernel: eth0: Lite-On PNIC-II rev 37 at 0xdc00,
00:C0:F0:7B:E2:D6, IRQ 10.
Aug 29 12:25:16 kalman kernel: lance.c: No PCnet/LANCE card found (i/o =
0xe000).

same when i try to insmod it by hand:
 modprobe eth1
 /lib/modules/2.4.9/kernel/drivers/net/lance.o: init_module: No such
 device or address
 Hint: insmod errors can be caused by incorrect module parameters,
 including invalid IO or IRQ parameters
 /lib/modules/2.4.9/kernel/drivers/net/lance.o: insmod
 /lib/modules/2.4.9/kernel/drivers/net/lance.o failed
 /lib/modules/2.4.9/kernel/drivers/net/lance.o: insmod eth1 failed


ayahhh, for a short time this second card responded to pings.... no it
wont even load.... what's going wrong? and is there any way i can change
the IRQ's of those damn cards? the module options need the iorq settings
but are completely ignoring them!

(and i have currently 4 cards on irq9 and 2 on irq10....)

-- 
ciao bboett
==============================================================
bboett@earthling.net
http://inforezo.u-strasbg.fr/~bboett http://erm1.u-strasbg.fr/~bboett
===============================================================
the total amount of intelligence on earth is constant.
human population is growing....
