Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSEUX0R>; Tue, 21 May 2002 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316779AbSEUX0Q>; Tue, 21 May 2002 19:26:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43434 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316778AbSEUX0P>;
	Tue, 21 May 2002 19:26:15 -0400
Date: Tue, 21 May 2002 22:08:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
Message-ID: <20020521220854.A12368@ucw.cz>
In-Reply-To: <3CEA7740.7060204@evision-ventures.com> <Pine.LNX.4.44.0205211041460.2634-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 10:56:14AM -0700, Linus Torvalds wrote:

> > The other things which ll_rw_blk.c doesn't get right is the
> > fact that the current merge functions don't respect hard sector
> > sizes
> 
> They aren't there to be respected by the ll_rw_blk layer - if some layer
> above it has created a request larger than the hard sector size, THAT is
> the problem, and there is nothing ll_rw_blk can do (except maybe BUG() on
> it, but I don't think we've ever really seen those kinds of bugs).

Hum, I'm confused here - shouldn't that be "if some layer above it has
created a request SMALLER than the hard sector size"? Or better a
request that is not a multiple of hard sector size?

-- 
Vojtech Pavlik
SuSE Labs
