Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311308AbSCMUev>; Wed, 13 Mar 2002 15:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311324AbSCMUel>; Wed, 13 Mar 2002 15:34:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20748 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311308AbSCMUeX>;
	Wed, 13 Mar 2002 15:34:23 -0500
Date: Wed, 13 Mar 2002 21:34:08 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
Message-ID: <20020313203408.GD20220@suse.de>
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv> <a6o30m$25j$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6o30m$25j$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13 2002, Linus Torvalds wrote:
> In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
> Roman Zippel  <zippel@linux-m68k.org> wrote:
> >
> >I first noticed the problem on my Amiga, but I can reproduce it on an ia32
> >machine, when I turn off dma with hdparm.
> 
> With PIO, the current IDE/bio stuff doesn't like the write-multiple
> interface and has bad interactions. 
> 
> Jens, you talked about a patch from Supparna two weeks ago, any
> progress?

I can fix this tomorrow, the stuff from Supparna was just a small bio
helper to retrieve the segments in a request. Just what we need for
write-multi.

-- 
Jens Axboe

