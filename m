Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbSKVAQD>; Thu, 21 Nov 2002 19:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSKVAQD>; Thu, 21 Nov 2002 19:16:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64267 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267237AbSKVAQC>; Thu, 21 Nov 2002 19:16:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] kill i_dev
Date: 21 Nov 2002 16:22:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <arjtcu$8q3$1@cesium.transmeta.com>
References: <UTC200211212346.gALNkem21004.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0211211548530.5779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0211211548530.5779-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Applied.
> 
> > There is a single side effect: a stat on a socket now sees
> > a nonzero st_dev. There is nothing against that - FreeBSD
> > has a nonzero value as well - but there is at least one
> > utility (fuser) that will need an update.
> 
> Looking at the patch (not testing it), as far as I can tell we'll return a 
> basically random number that is just whatever the anonymous super-block 
> was allocated, right?
> 
> I'm not convinced that returning random numbers to user space is
> necessarily a great idea.. That said, I think we already do it for unnamed
> pipes anyway, so I'm more wondering if we should have some way to map
> these numbews (in user space) to a valid thing, so that they wouldn't just
> be random numbers.
> 

What's really important is that they don't map to anything else.  I
don't think it matters what the numbers is, since there is a much
better way to find out that you're a pipe or a socket.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
