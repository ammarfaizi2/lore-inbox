Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133102AbQLOAGp>; Thu, 14 Dec 2000 19:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOAGf>; Thu, 14 Dec 2000 19:06:35 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:58889 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S133102AbQLOAG1>; Thu, 14 Dec 2000 19:06:27 -0500
Date: Thu, 14 Dec 2000 18:35:59 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001214183559.M760@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com> <91b610$biq$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <91b610$biq$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 14, 2000 at 11:11:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 11:11:28AM -0800, Linus Torvalds wrote:
> user applications and (b) gcc-2.96 is so broken that it requires special
> libraries for C++ vtable chunks handling that is different, so the
> _working_ gcc can only be used with programs that do not need such
> library support.

Every major g++ release had incompatible libstdc++, even g++ 2.95.2 if
bootstrapped under glibc 2.1.x is binary incompatible with g++ 2.95.2
bootstrapped under glibc 2.2.x (libstdc++ uses different soname then;
even if we used g++ 2.95.2 we would not have C++ binary compatible with
other distributions).
This will change once 3.0 is out, but it will still take some time.

> compiler to something that works better RSN.  It apparently has problems
> compiling stuff like the CVS snapshots of X etc too (and obviously,
> anything you compile under gcc-2.96 is not likely to work anywhere else
> except with the broken libraries). 

Can you point to things in X which were actually miscompiled because of bugs
in gcc 2.96? So far I was aware about X bugs (already fixed in X CVS) which
were triggered with -fstrict-aliasing which is now the default while
gcc 2.95.2 had -fstrict-aliasing disabled by default.
That is not to say there were not bugs in the gcc we shipped, but the bugs
which were reported against it have been fixed already.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
