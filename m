Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131464AbQLSA7X>; Mon, 18 Dec 2000 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131628AbQLSA7N>; Mon, 18 Dec 2000 19:59:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3886 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131464AbQLSA6y>; Mon, 18 Dec 2000 19:58:54 -0500
Date: Tue, 19 Dec 2000 01:27:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001219012714.B26127@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0012181847360.2595-100000@duckman.distro.conectiva> <Pine.LNX.3.96.1001218224636.1190D-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1001218224636.1190D-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Mon, Dec 18, 2000 at 10:57:44PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 10:57:44PM +0100, Mikulas Patocka wrote:
> You have small posibility that interrupt will eat up memory - interrupt in
> process that has PF_MEMALLOC. Patch: 

this is not the point of getblk, to fix the getblk deadlock the only way is to
implement a fail path in each caller and allow getblk to return NULL (as every
other memory allocation function can do).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
