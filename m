Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSLMQ21>; Fri, 13 Dec 2002 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLMQ20>; Fri, 13 Dec 2002 11:28:26 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:46728 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265097AbSLMQ2Z>;
	Fri, 13 Dec 2002 11:28:25 -0500
Date: Fri, 13 Dec 2002 16:36:01 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: BoehmeSilvio <Boehme.Silvio@afb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1 KT400 AGP support
Message-ID: <20021213163601.GB1633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	BoehmeSilvio <Boehme.Silvio@afb.de>, linux-kernel@vger.kernel.org
References: <2F4E8F809920D611B0B300508BDE95FE294452@AFB91>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F4E8F809920D611B0B300508BDE95FE294452@AFB91>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 11:18:39AM +0100, BoehmeSilvio wrote:

 > I don't need the AGP 8X mode, but is it possible,
 > to get this setup running in whatever agp mode ?

You misunderstand. You have an AGP 3.0 bridge.
Various things are done differently to how they were in previous
revisions of the standard. For example, the aperture size is now
a 16 bit field (which is why people are getting that
"can't determine aperture size" error).

I'm working on merging the Intel patches posted here a while
ago, and bending the generic bits into something that *might*
work (I don't have a board to test -- I'll shout when I have
something I want people to test with), note that I'm doing this
for 2.5 however. 2.4 is going to have to wait.

 > Currently it is only possible to start X with VESA support,
 > because all other drivers need agpgart.

X should start, but you'll get no accelerated 3d.
None of the X drivers _need_ agpgart except for maybe the
i810 with shared memory.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
