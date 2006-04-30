Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWD3U1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWD3U1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 16:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWD3U1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 16:27:48 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:22534 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751004AbWD3U1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 16:27:47 -0400
Message-ID: <44551DD2.3080708@gmail.com>
Date: Sun, 30 Apr 2006 22:27:39 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Professor Moriarty <bofh.h4x@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: irq event 5: bogus return value 19
References: <2a56523e0604301219s67244272n7e8ee7c634a1933c@mail.gmail.com>
In-Reply-To: <2a56523e0604301219s67244272n7e8ee7c634a1933c@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Professor Moriarty napsal(a):
> On debugging a soundcard driver (the Riptide driver from linuxant,
> ported by me to 2.6), I seem to have 2 weird bugs that are giving me a
> headache:
> Both occur when I try to actually play a file
> The first: ppos != &file->f_pos
> If I comment that check out, I get a kernelpanic. If I comment out the
> schedule_work() to run the bottom half of the IRQ handler, I get the
> message:
> irq event 5: bogus return value 19
> Followed by:
> kernel: Disabling IRQ #5
> At this point, the first 4K of raw PCM plays, and then /dev/dsp
> blocks, while the speakers repeat the 4K of data repeatedly until I
> ctrl+C mplayer. Trying to cat data to /dev/dsp plays first 4K, then
> cat says /dev/dsp is out of space.
> 
> Any ideas?
Give us (at least parts of) the code and then we can tell you, now it may be
like a shot in the dark.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVR3SMsxVwznUen4RAgDzAJ9pSjjRRzeiD5PYgF1eon1Q6dYmEwCeOVRN
pmURuwCGXGVXwUN2Qbafvn0=
=5Tj8
-----END PGP SIGNATURE-----
