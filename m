Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHVSVZ>; Thu, 22 Aug 2002 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHVSVY>; Thu, 22 Aug 2002 14:21:24 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56846 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315440AbSHVSVY>; Thu, 22 Aug 2002 14:21:24 -0400
Date: Thu, 22 Aug 2002 19:25:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: New large block-device patch for 2.5.31+bk
Message-ID: <20020822192531.A27750@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <15716.29133.542866.358607@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15716.29133.542866.358607@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Thu, Aug 22, 2002 at 03:08:29PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 03:08:29PM +1000, Peter Chubb wrote:
> 
> Hi,
> 	Here's the latest large-block device patch.  Expect more
> changes as Al Viro continues his partition cleanup (I've just
> converted int *xxx_sizes to sector_t *xxx_sizes; he's gradually
> getting rid of xxx_sizes[] altogether --- and a good thing too!).
> 
> I think I've addressed all the comments I've received so far, except
> for the request for something that works on 2.4.X.
> 
> The patch enables support for large (>2TB) block devices for all platforms
> where sizeof(long)==8, and via a config option for power-PC and IA32.
> It's been tested on IA64 and IA32 only.

I don't have much comments left :)  What about moving the sector_t typedef
completly to <asm/types.h>?  Looks like the cleanest solution to me.

I also wonder whether CONFIG_LBD might want to move to arch/*/config.

An a little suggestion:  you could feed that patch to Linus in pieces.
The printk cleanups might be a good start.

