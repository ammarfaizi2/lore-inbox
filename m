Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284049AbRLAKvd>; Sat, 1 Dec 2001 05:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLAKvX>; Sat, 1 Dec 2001 05:51:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12160 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S284049AbRLAKvO>; Sat, 1 Dec 2001 05:51:14 -0500
Date: Sat, 1 Dec 2001 03:55:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011201035516.B10743@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <01112715312104.01486@localhost> <20011128194302.A29500@emma1.emma.line.org> <01112813462404.01163@driftwood> <20011128231925.A7034@emma1.emma.line.org> <20011129232157.A211@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129232157.A211@elf.ucw.cz>; from pavel@suse.cz on Thu, Nov 29, 2001 at 11:21:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check out the hotfixing code in NWFS.  It handles exactly what this 
long and drawn out thread has discussed, and it's already in 
Linux.  The code is contained in nwvp.c.  I can tell you 
that in the past three years of running NWFS on Linux and all
the time I worked at Novell from about 1996 on, I never once saw 
a server hotfix data after the newer "data guard" drive technologies
came out.  In fact, by default, I make the hotfix area on the drive
about .1 % of the total space, since it;s probably just wasted 
space at this point.  

It's just wasted space these days, but it is a good idea to keep it 
around, just in case the "pointless" argument turns out not to 
be pointless and someone gets eaten by a shark (1 in 100,000,000) at
the same instant they are struck by lightening (1 in 200,000,000).

:-)
Jeff


On Thu, Nov 29, 2001 at 11:21:57PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Assuming the drive's inherent bad-block detection mechanisms don't find it 
> > > and remap it on a read first, rapidly consuming the spare block reserve.  But 
> > > that's a firmware problem...
> > 
> > Drives should never reassign blocks on read operations, because they'd
> > take away the chance to try to read that block for say four hours.
> 
> Why not? If drive gets ECC-correctable read error, it seems to me like
> good time to reassign.
> 								Pavel
> -- 
> "I do not steal MS software. It is not worth it."
>                                 -- Pavel Kankovsky
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
