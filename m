Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271182AbRHYVdS>; Sat, 25 Aug 2001 17:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271185AbRHYVdI>; Sat, 25 Aug 2001 17:33:08 -0400
Received: from mx2.port.ru ([194.67.57.12]:29708 "EHLO mx2.port.ru")
	by vger.kernel.org with ESMTP id <S271182AbRHYVc6>;
	Sat, 25 Aug 2001 17:32:58 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: hahn@coffee.psychology.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Subject: unrelated 2.4.x (x=0-9) sound
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.212]
Date: Sat, 25 Aug 2001 21:33:13 +0000 (GMT)
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15al3J-0008xK-00@f8.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      i feel like the media isn`t downgrading because
> >  the badblocks _arent_ physical: low-level drive
> >  reformat doesnt show anything.

> the low-level format merely remaps bad blocks to spare ones.
> eventually, you'll run out of spare blocks, and then...
    no no no - when ibm DFT (drive fitness test)
  runs on physical bblks i _hear_ this! (and also
  it tells me).

    also how do you like _continuous_ 100-200 - large
  zone of bblks, and _nothing_ more!

    it these were real bblks, they appears like
  dots on surface, thus killing _physically_ neighbouring
  sectors of _different_ cylinders, so there should be
  some cyclic pattern of them.

    And in my case the is not pattern - there is only
  a sequence of 100-200 bblks...

    You ask how do i know this? I had wrote a modification
  to debugreiserfs which in early versions scanned
  journal for bblks and zeroified them, so they
  are remapped(?), and later i rewroted it to scan
  the whole drive, so i know here the situation...

> but the whole point of checksum errors is that the corrupted
> transfer is discarded and retried.  just like with TCP or UDP.
  okay, i`d selected the wrong exmple, but
  imagine:
   1. drive gets data over udma along with crc.
   2. drive checks crc(data) with crc_from_udma_cable,
    and it is okay.
     3a. drive corrupts data.
     4a. drive writes the corrupted data, with right crc.
     3b. drive corrupts crc.
     4b. drive writes the right data with corrupted crc.
   The only assumption here is needed, is that
  these corruptions belongs only to the udma-specific
  process... (e.g why UDMA?)

> also, aren't the corruptions to specific blocks?  the kind
> of checksum failure you're talking about would be uniformly
> distributed over all transfers, not sector-specific.
   internal drive super-optimizing firmware is black magik... (remember pentium-math issues?)

---


cheers,


   Samium Gromoff
