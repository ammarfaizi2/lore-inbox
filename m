Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJKNaH>; Fri, 11 Oct 2002 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbSJKNaH>; Fri, 11 Oct 2002 09:30:07 -0400
Received: from users.linvision.com ([62.58.92.114]:50836 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262434AbSJKNaG>; Fri, 11 Oct 2002 09:30:06 -0400
Date: Fri, 11 Oct 2002 15:35:38 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Walter Landry <wlandry@ucsd.edu>, linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
Message-ID: <20021011153538.A345@bitwizard.nl>
References: <20021009.163920.85414652.wlandry@ucsd.edu> <3DA58B60.1010101@pobox.com> <20021010072818.F27122@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010072818.F27122@work.bitmover.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 07:28:18AM -0700, Larry McVoy wrote:
> > The laptop has 200MB RAM, and mozilla and a ton of xterms loaded.  IDE 
> > drives w/ Intel PIIX4 controller.  The Dual Athlon has 512MB RAM, and I 
> > forget what kind of IDE controller -- I think AMD.  IDE drives as well.
> > 
> > BitKeeper must scan the entire tree when doing a checkin or checkout, so 

[...]

> In low memory situations you really want to run the tree compressed.  
> ON a fast machine do a "bk -r admin -Z" and then clone that onto your
> laptop.  I think that will drop the tree to about 145MB which will
> help, maybe.  I suspect that you use enough of the rest of your 200MB
> that it still won't fit.

[...]
> There is only so much we can do when you are trying to cram 10 pounds of
> crap in a 5 pound bag :(

The reason that one or two years ago my "diff+multiple trees" beat
bitkeeper on the performance front was that diff would only touch
inode-metadata, and not the files themselves. You can cache the
file-metadata (inodes) of a 200M tree in a couple of megabytes of RAM.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
