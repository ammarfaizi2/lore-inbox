Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281219AbRKEQkT>; Mon, 5 Nov 2001 11:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKEQkD>; Mon, 5 Nov 2001 11:40:03 -0500
Received: from oracle.clara.net ([195.8.69.94]:10256 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S281223AbRKEQjt>;
	Mon, 5 Nov 2001 11:39:49 -0500
To: linux-kernel@vger.kernel.org
Path: softins.clara.co.uk!not-for-mail
From: tony@softins.clara.co.uk (Tony Mountifield)
Newsgroups: linux.kernel
Subject: aic7xxx problems with AHA2930CU
Date: 5 Nov 2001 16:39:46 -0000
Organization: Software Insight Ltd., Winchester, UK
Message-ID: <9s6fci$3f7$1@softins.clara.co.uk>
X-Newsreader: trn 4.0-test69 (20 September 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I originally posted this query on aic7xxx@freebsd.org back in August,
but had no responses at all. I hope someone here can advise. I have added
a bit more at the end.

---start original query

I have a completely SCSI-based system which uses an AHA2930CU host adapter
on a SiS-based motherboard to drive two hard drives and a CD-ROM. It has
been running RedHat 6.2 with kernel 2.2.16 very happily for a long time.
This has aic7xxx 5.1.30/3.2.4.

In order to get USB support for my ADSL modem I decided to upgrade to RH
7.1. But the installer's aic7xxx wouldn'trun properly, giving many SCSI
errors, usually starting with Data Overrun errors due to an unexpected data
phase, and ending up complaining of CHECK condition during REQUEST SENSE.
This was aic7xxx 5.2.4/5.2.0.

I also tried the RawHide install disk and the one from Mandrake 8.0. Both
exhibited similar problems.

Using expert install and selecting aic7xxx_mod was no better.

The next thing I tried was installing the RedHat 6.2 update to kernel
2.2.19. This has aic7xxx 5.1.33/3.2.4. It also failed to boot, with
similar SCSI errors to those described above.

I found Doug's SCSI driver page and downloaded the 5.1.33 patch. I then
reverse-applied it to the 2.2.19 kernel tree to downgrade the aic7xxx from
5.1.33 to 5.1.31 and rebuilt the kernel. This kernel DID boot successfully
with no SCSI errors at all!

So something in the mega-update from 5.1.31 to 5.1.33 severely broke the
AHA2930CU card (AIC7860), at least on my system, and this brokenness has
persisted through the few later versions that I've tried.

How can I help solve this? Are the later 6.2.x drivers likely to be better?

---end original query

I have been running fine for over two months with 2.2.19 and the old 5.1.31
SCSI driver. When Red Hat 7.2 came out recently I though I would try again,
and created a boot floppy and a driver floppy.

Booting with these still displayed the problems I described.
Using aic7xxx_mod (6.1.13) instead of aic7xxx resulted in a kernel panic.

I'd really like to move to the 2.4 kernels - how can I determine what needs
doing to the aic7xxx to support the 2930CU card?

Cheers,
Tony

-- 
Tony Mountifield
Work: tony@softins.co.uk - http://www.softins.co.uk
Play: tony@mountifield.org - http://tony.mountifield.org
