Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbRLaDNJ>; Sun, 30 Dec 2001 22:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbRLaDMu>; Sun, 30 Dec 2001 22:12:50 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:27026 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286184AbRLaDMt>; Sun, 30 Dec 2001 22:12:49 -0500
Date: Mon, 31 Dec 2001 03:15:06 +0000
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: merge in progress.
Message-ID: <20011231031506.A1537@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, pre5 gets us in sync with most of the important and easy
to merge bits. Here's a list of whats left between the trees.


Pending:
o  Bunch of __devexit changes
o  Keith's text.lock -> .subsection changes
   Better to merge this first and see whats left broken before merging
   the __devexit changes, in case there are any more bogus ones.
o  Small EISA cleanups
o  Lots of driver updates for ieee1394, ISDN, network drivers, parport
   & paride, USB, MTD.  Hopefully the larger subsystems like USB will
   get pushed by the relevant maintainers who can explain their bits
   to Linus a lot better than I can.
o  VM updates.
o  Various documentation (Will do this last).
o  A few other small things that don't fall under any specific category.
   Code formatting cleanups etc..


Things unlikely to merge yet.
o  Alans aacraid driver (not bio aware)
o  James Simmons fbdev cleanups (needs more testing)
o  Thomas Hoods PNPBIOS work (little more testing to be sure)
o  sbp2 driver fixes from 2.4 (They break with bio)
o  Simple Boot Flag support (more work needed)
o  Small MP Table parsing changes (more testing needed)
o  Reiserfs fixes.
   (Waiting to hear back from the reiserfs folks that I did these ok)


Maybe:
o  Various other driver fixes
   Look ok, depends on next steps for bio.
o  Various sound driver updates.
   Worth doing these with ALSA hopefully on the way ?
o  Manfreds Dynamic LDT
   Needs checking that it hasn't broken x86 math-emu.
o  net core updates
   I'd rather leave this to davem, and see whats left over.
o  Large arch updates for PPC, s390/s390x & Sparc/Sparc64
   Could merge these, or wait for relevant arch maintainer
   to feed maybe newer updates to Linus.


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
