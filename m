Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRJUUUC>; Sun, 21 Oct 2001 16:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276720AbRJUUTw>; Sun, 21 Oct 2001 16:19:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25356 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276709AbRJUUTn>; Sun, 21 Oct 2001 16:19:43 -0400
Date: Sun, 21 Oct 2001 22:20:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: tytso@mit.edu
Subject: Warning about wssusp & 2.4.12 + ask  ask for help
Message-ID: <20011021222013.B23174@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I never releasedswsusp for 2.4.10, but it is easy to port. If you prot
it, be *extremely* carefull. It managed to kill my / directory by
overwriding inodes <14 with junk. It worked pretty well under 2.4.10.

Now I have corrupted / fs. After 10-or-so-fscks, I got to the state
when only error is 

Block bitmap differences: +0 +1 ... +32767.

But even if I ask to fix it, its back there on next fsck (both on
2.4.? and 2.2.9), so I suspect fsck bug. fsck is e2fsck 1.18.

Is it known bug or is someone willing to chase it? Is it safe to boot
with this problem going multiuser?
				Pavel 
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
