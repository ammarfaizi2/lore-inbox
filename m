Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTENGKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTENGKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:10:36 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:46466 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262110AbTENGKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:10:02 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513011232.67c300d0.akpm@digeo.com>
	<87addq7fr8.fsf@lapper.ihatent.com>
	<20030513145335.2337e0f7.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 14 May 2003 08:22:48 +0200
In-Reply-To: <20030513145335.2337e0f7.akpm@digeo.com>
Message-ID: <87smri59on.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:

> > * On -mm3 under some loads mplayer can get very erratic, and after
> >   playing a videostream for about 10-15 mins it gets progressivly more
> >   prone to stalling. Moving the mousepointer into the window, and wiggling
> >   it a bit restores it for a while.
> 
> grr.  Can you run `vmstat 1' and see if those stalls correspond with swap
> or disk I/O?

Here's the result of some light poking in my mailbox (moving single
mails form one folder to another, moved about 8 mails while this
scrolled by:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1   3700   4640   3568 479976    0    0   128 16020 2233  1926 50  4  0 46
 0  1   3700   4512   3568 463812    0    0   128  8704 2233  2856 13  4  0 83
 0  0   3700   5728   3624 500064    0    0   128  3424 2161  1428 51 21  8 20
 0  0   3700   5664   3624 500192    0    0   128     0 2070  2496 12  2 86  0
 0  1   3700   5536   3628 500320    0    0   128 13496 2188  2560 13  3 43 41
 9  1   3700   5408   3628 500448    0    0   128 16904 2325  2614 17  3  0 80
 0  1   3700   4576   3628 468596    0    0   128  8516 2222  2418 34  6  0 60
 3  1   3700   4832   3680 493404    0    0   128  7620 2220  1403 51 20  0 29
 0  0   3700  12192   3692 493532    0    0   132   180 2156  2601 18  3 45 33
 0  1   3700  12064   3716 493660    0    0   148 16372 2152  2640 13  3 40 45
 0  1   3700  11232   3724 477160    0    0   128  9488 2217  2392 38  5  0 57
 0  2   3700  11044   3724 460640    0    0   132  8960 2230  2869 13  4  0 83
 1  0   3700  15588   3788 489996    0    0   132 11896 2195  1246 61 19 16  4
 1  0   3700  15460   3788 490124    0    0   128     0 2078  2480 13  2 85  0
 0  2   3700  15284   3796 490252    0    0   128 10332 2198  2974 26  5 26 42
 0  2   3700  15220   3800 490380    0    0   128 16924 2310  2653 20  3  0 77
 0  1   3700  15092   3800 490508    0    0   128 17688 2363  2842 23  3  0 74
 0  0   3700  15348   3808 490636    0    0   128  1768 2239  2510 19  4 12 65
 0  0   3700  15220   3808 490764    0    0   128     0 2098  2584 19  2 79  0
 alexh@lapper ~ $

I'll have a hunt around to get more output if you want?

mvh,
A

- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+weC1CQ1pa+gRoggRAjbHAKDHRp0FG4CLzcFLCaHST7ubrf4vyACgpQXM
vRWdd2M1QOfy/LMvyJphYzw=
=zuYD
-----END PGP SIGNATURE-----
