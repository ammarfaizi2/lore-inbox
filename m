Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284095AbRLANFr>; Sat, 1 Dec 2001 08:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284096AbRLANFh>; Sat, 1 Dec 2001 08:05:37 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:17577 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284095AbRLANFZ>; Sat, 1 Dec 2001 08:05:25 -0500
Date: Sat, 1 Dec 2001 15:10:08 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup
In-Reply-To: <E16A9WI-00073W-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112011500590.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Alan Cox wrote:

> IMHO this is precisely the wrong thing to do.
>
> We should make the = NULL check within kfree do a BUG() call. That way we
> fix the cases not being considered instead of hiding real bugs

I agree, but looking at the common case, it would mean lots of extra null
checks all over the place. And most people seem used to the idea of free
doing nothing when called with a NULL pointer, of course people can always
change...

Cheers,
	Zwane Mwaikambo


