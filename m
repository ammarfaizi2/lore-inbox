Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLOTZy>; Fri, 15 Dec 2000 14:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbQLOTZg>; Fri, 15 Dec 2000 14:25:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28490 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129521AbQLOTZV>; Fri, 15 Dec 2000 14:25:21 -0500
Date: Fri, 15 Dec 2000 19:54:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215195433.G17781@inspiron.random>
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215175632.A17781@inspiron.random> <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215184325.B17781@inspiron.random> <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com>; from Franz.Sirl-kernel@lauterbach.com on Fri, Dec 15, 2000 at 06:59:24PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 06:59:24PM +0100, Franz Sirl wrote:
> It's required by ISO C, and since that's the standard now, gcc spits out a 
> warning. Just adding a ; is enough and already done for most stuff in 
> 2.4.0-test12.

I'm not complaining gcc folks, I just dislike the new behaviour in general,
it's inconsistent.

This is wrong:

x()
{

	switch (1) {
	case 0:
	case 1:
	case 2:
	case 3:
	}
}

and this is right:

x()
{

	switch (1) {
	case 0:
	case 1:
	case 2:
	case 3:
	;
	}
}

Why am I required to put a `;' only in the last case and not in all
the previous ones? Or maybe gcc-latest is forgetting to complain about
the previous ones ;)

Anyway it's a minor issue, if the standard says so we'll live with it.

(and it's also getting offtopic...)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
