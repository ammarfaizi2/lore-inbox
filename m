Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSFMSpX>; Thu, 13 Jun 2002 14:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317794AbSFMSpW>; Thu, 13 Jun 2002 14:45:22 -0400
Received: from uvo1-74.univie.ac.at ([131.130.231.74]:7564 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S317619AbSFMSpV>;
	Thu, 13 Jun 2002 14:45:21 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: billy@oconnoronline.net
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
Date: Thu, 13 Jun 2002 20:44:59 +0200
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206131917.49235@pflug3.gphy.univie.ac.at> <20020613173422.B0D0D89@dps7.oconnoronline.net>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206132045.02216@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Billy O'Connor -- Thursday 13 June 2002 19:34:
> This bit here, in Type1OpenScalable()?
> 
>   /* heuristic for "maximum" size of pool we'll need: */
>   size = 200000 + 120 *

Yes. I simply replaced 120 by 600 after which it processed even the
biggest of my fonts scaled to 1000 points, without aborting. But there
might be bigger fonts.
   Note that there are 2 further places where these (wrong) heuristics
are used, and I changed 120 -> 600 there, too (4 times in summary).
This is, however, no elegant solution. The XFree people discuss meanwhile
to replace the whole type1 stuff by the one from freetype2.

m.
