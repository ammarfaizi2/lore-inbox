Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131166AbQKPQqw>; Thu, 16 Nov 2000 11:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKPQqm>; Thu, 16 Nov 2000 11:46:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24150 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129222AbQKPQqX>; Thu, 16 Nov 2000 11:46:23 -0500
Date: Thu, 16 Nov 2000 17:16:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001116171618.A25545@athlon.random>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001116150704.A883@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Nov 16, 2000 at 03:07:04PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 03:07:04PM +0100, Matthias Andree wrote:
> It shows a program that saves the cwd -- open(".",...) in an open file,
> then chroots [..]

This is known behaviour (I know Alan knows about it too), solution is to close
open directories filedescriptors before chrooting.

Everything that happens before chroot(2) is trusted, so it's secure to rely
on it to close directories first.

If this is not well documented and people doesn't know about it and so they
writes unsafe code that's another issue...

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
