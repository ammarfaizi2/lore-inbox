Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbRGUOqC>; Sat, 21 Jul 2001 10:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbRGUOpw>; Sat, 21 Jul 2001 10:45:52 -0400
Received: from ch-12-44-140-162.lcisp.com ([12.44.140.162]:51073 "HELO
	dual.lcisp.com") by vger.kernel.org with SMTP id <S267643AbRGUOph>;
	Sat, 21 Jul 2001 10:45:37 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Brad Chapman" <kakadu@earthlink.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Strange behavior with 2.4.x on a Celeron
Date: Sat, 21 Jul 2001 09:45:23 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALAEKJELAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B58D19A.9080509@earthlink.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Is your hard drive setup for DMA?

Run
/sbin/hdparm /dev/hda
to check.

If so, you may want to tweak some settings, or even check that your cables
are good and don't go too near other cables.

I had similar problems when I bought a new UDMA/100 hard drive and wanted to
connect it to my HT366 controller rather than my ATA/33 controller.  It
would work for awhile, then under heavy load I would loose an IRQ and I had
to do a hard reset.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Brad Chapman
Sent: Friday, July 20, 2001 7:50 PM
To: linux-kernel@vger.kernel.org
Subject: Strange behavior with 2.4.x on a Celeron


Hello,

   I have a Celeron 400MHz/66MHz with 256MB of RAM, a 6.4GB Quantum Fireball
and an onboard SiS AGP chipset. I am currently running 2.4.5. I have
noticed
that when I unpack large tar files on my system, it will sometimes lock up
the hard disk, and I would also guess the filesystem code with it. When
I try
to switch to another VC to kill the tar process, it hangs when I run ps ax.
When I try to run ANY command which accesses the hard disk, it also hangs.
Accessing /proc or /dev (I use devfs) doesn't cause any problems. Anyone
have
any ideas?

Thanks,

Brad

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


