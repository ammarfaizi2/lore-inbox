Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVCUTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVCUTBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCUTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:01:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34505 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261590AbVCUTBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:01:04 -0500
Date: Mon, 21 Mar 2005 20:00:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321190044.GD1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423EEEC2.9060102@lougher.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>Also, this filesystem seems to do the same thing as cramfs.  We'd need to
> >>>understand in some detail what advantages squashfs has over cramfs to
> >>>justify merging it.  Again, that is something which is appropriate to the
> >>>changelog for patch 1/1.
> >>
> >>Well, probably Phillip can answer this better than me, but the main 
> >>differences that affect end users (and that is why we are using SquashFS 
> >>right now) are:
> >>                         CRAMFS          SquashFS
> >>
> >>Max File Size               16Mb               4Gb
> >>Max Filesystem Size        256Mb              4Gb?
> >
> >
> >So we are replacing severely-limited cramfs with also-limited
> >squashfs... 
> 
> I think that's rather unfair, Squashfs is significantly better than 
> cramfs.  The main aim of Squashfs has been to achieve the best 

Yes, it *is* rather unfair. Sorry about that. But having 2 different
limited compressed filesystems in kernel does not seem good to me.

> compression (using zlib of course) of any filesystem under Linux - which 
> it does, while also being the fastest.  Moving beyond the 4Gb limit has 
> been a goal, but it has been a secondary goal.  For most applications 
> 4Gb compressed (this equates to 8Gb or more of uncompressed data in most 
> usual cases) is ok.

Okay, having limit on 4GB compressed is slightly better (and should
mean that SquashFS would actually be usefull to me).

> >For live DVDs etc 4Gb filesystem size limit will hurt for
> >sure, and 4Gb file size limit will hurt, too. Can those be fixed?
> 
> Almost everything can be fixed given enough time and money. 
> Unfortunately for Squashfs, I don't have much of either.  I'm not paid 
> to work on Squashfs and so it has to be done in my free time. I'm hoping 
> to get greater than 4Gb support this year, it all depends on how much 
> free time I get.

Well, out-of-tree maintainenance takes lot of time, too, so by keeping
limited code out-of-kernel we provide quite good incentive to make
those limits go away.

Perhaps squashfs is good enough improvement over cramfs... But I'd
like those 4Gb limits to go away.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
