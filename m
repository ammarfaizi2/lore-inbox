Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVFMKpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVFMKpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVFMKod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:44:33 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:56239 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S261465AbVFMKoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:44:21 -0400
Message-ID: <42AD649E.1020901@stesmi.com>
Date: Mon, 13 Jun 2005 12:49:02 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
In-Reply-To: <f192987705061303383f77c10c@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> I have a Great Idea about improving NLS in the linux kernel and I want
> somebody with kernel experience consider if it's good or not, just not
> to waste time on writing code that will be rejected.
> 
> First of all, why do I think the current NLS implementation isn't good enough.
> 
> Let's look at a situation. I'm using utf-8 as my default system
> charset, and my friend Vasiliy Pupkin, who uses koi8-r, wants to plug
> his flash drive (ext3) into my computer. It should work, except all
> non-us-ascii filenames will be totally unreadable. The problem is even
> bigger if I have an other friend's hard drive with reiserfs and cp1251
> encoded filenames on it. The problem is not only with Russian language
> for which we have at least 3 common encodings. Everyone who uses
> non-us-ascii letters can face the same problem, since there are at
> least 2 encodings for theyr language - utf-8 and an other one used
> before utf.
> 
> Some would suggest not to use non-ascii file names at all, some would
> say that I should temporary change my locale, some could even offer me
> a perl script they wrote when faced the same problem. All these
> solutions are inconvenient and conflict with fundamental VFS concepts.
> 
> Instead of adding NLS support to filesystems who don't have it yet, I
> think there should be a global NLS layer, to convert file names from
> any to any encoding, independent of file system and transparently to
> the user.
> 
> So what do you think? Is it all nonsense or maybe I should try to implement it?

What do you do when a charset doesn't contain a char that another one
does?

Compare the two very similar charsets ISO-8859-1 and ISO-8859-15 and
have the Euro-sign using ISO-8859-15. Then try to make that into
something sane.

Not knocking you or anything, you just have to think about these
pitfalls.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCrWSeBrn2kJu9P78RAkZNAKCjRkxx4EnZT+C8wblPB/AH63xz2ACfS4m6
IrVy4TwcwWH2Wm1Va+SN0XI=
=SYdz
-----END PGP SIGNATURE-----
