Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSE1CEp>; Mon, 27 May 2002 22:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316818AbSE1CEo>; Mon, 27 May 2002 22:04:44 -0400
Received: from squeaker.ratbox.org ([63.216.218.7]:23567 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S316804AbSE1CEn>; Mon, 27 May 2002 22:04:43 -0400
Date: Mon, 27 May 2002 22:04:41 -0400 (EDT)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <pwaechtler@loewe-komp.de>, <austin@digitalroadkill.net>
Subject: Re: RT Sigio broken on 2.4.19-pre8
In-Reply-To: <3CF2D86C.8745D791@kegel.com>
Message-ID: <Pine.LNX.4.44.0205272203130.6201-100000@simon.ratbox.org>
X-GPG-FINGRPRINT: 1024D/D4DE2553 0E60 59B5 60DA 2FD3 F6F5  27A3 6CD2 21AD D4DE 2553
X-GPG-PUBLIC_KEY: http://squeaker.ratbox.org/androsyn.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On Mon, 27 May 2002, Dan Kegel wrote:
>
> That sounds like the way I'm clearing the signal queue is not working.
> Here's a minimal test case for clearing the signal queue.  Could
> you try it and tell me what it says?
> - Dan

The test passed.  What it looks like is, the kernel for some reason is not
decrementing the queued count for some reason.  I have a server doing RT
sigio and after a while, the rtsig-nr count goes up to 1024 and never
comes back down even if I kill that process.

Regards,

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE88uW7bNIhrdTeJVMRApXSAKCMolB/rzDvdin1byJo36ZYRw6mmACbBkLl
JGH5UDNRpg0AE0VK3lDaPGw=
=NUCR
-----END PGP SIGNATURE-----

