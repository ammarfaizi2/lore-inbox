Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSB0AEk>; Tue, 26 Feb 2002 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289858AbSB0AEg>; Tue, 26 Feb 2002 19:04:36 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:6667 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S289817AbSB0AD0>; Tue, 26 Feb 2002 19:03:26 -0500
Subject: Re: Change that to an NTFS bug not loopback
From: Richard Russon <rich@flatcap.org>
To: Barubary <barubary@cox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <000501c1bebf$80a3e460$a7eb0544@CX535256D>
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D>
	<3C7B7908.1040508@ellinger.de> <009c01c1bebe$41321730$a7eb0544@CX535256D> 
	<000501c1bebf$80a3e460$a7eb0544@CX535256D>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 00:03:20 +0000
Message-Id: <1014768201.17005.25.camel@addlestones>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barubary,

> I tried to mount a 20 meg ISO from an NTFS partition mounted read-only and
> it glitched.  It has nothing to do with the size of the file.  I would've
> checked smaller files if I had mkisofs handy, which I didn't when I tried
> it.

Reading through the thread, I've just tried everything you have.
I've used 2.4.18-rc4.  I've first mounted an NTFS partition.  Within
that I've mounted

1a)  Another NTFS partition (from a device)       1Gb   (< 2^31 bytes)
1b)  Another NTFS partition (from a device)       2.2Gb (> 2^31 bytes)
2)   Another NTFS partition (from a loop device)  2.2Gb (> 2^31 bytes)
3)   An ISO image (from a loop device)            20Mb  (< 2^31 bytes)

Please can you clarify what's going wrong.  I can't seem to get the
NTFS driver to go wrong.

If I can repeat the problem, I can probably fix it.

> Now I'm afraid that it's a known bug and I've wasted your time... :(

Don't worry.  If something doesn't work, someone here will want to hear
about it (and fix it).

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org

P.S.  Anton's on holiday (current NTFS maintainer), so you've got me :-)


