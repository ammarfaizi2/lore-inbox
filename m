Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVALQrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVALQrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVALQrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:47:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261248AbVALQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:47:38 -0500
Date: Wed, 12 Jan 2005 17:47:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Lang <dlang@digitalinsight.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112164729.GJ29578@stusta.de>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com> <20050111223641.GA27100@logos.cnet> <20050112023218.GF4325@ip68-4-98-123.oc.oc.cox.net> <20050112005647.GB27653@logos.cnet> <20050112061043.GG4325@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112061043.GG4325@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:10:43PM -0800, Barry K. Nathan wrote:
> On Tue, Jan 11, 2005 at 10:56:47PM -0200, Marcelo Tosatti wrote:
> > Out of curiosity do you have a list of such syscalls?
> 
> Not yet. I wasn't expecting to need the list quite this soon.
> 
> > "usually" is the problem - you cannot be sure what syscalls unknown
> > applications are using. 
> [snip]
> > > And if you have programs that need it, you (or your vendor) can set the
> > > config option accordingly.
> > 
> > The possibility is that there might be unknown applications which use
> > these "obsolete" system calls. 
> 
> True, but I would expect to see a strong correlation between the use of
> "obsolete" syscalls and the use of "obsolete" libraries (libc4, libc5).
> Until there's a list of obsolete syscalls, we can't say for sure,
> though.
>...

The only interesting correlation are system calls that are _only_ used 
by libc4/libc5 applications.

> > I personally dont like the idea of disabling "obsolete" system calls
> > with config options, but it is useful for specialized applications to
> > save memory. 
> > 
> > Are many users going to benefit from it?
> 
> It's going to be hard to tell without full-blown code to examine and
> test, but my hope is that it will be able to disable something
> substantial for people who have completely abandoned libc4/libc5. And
> that's many users.
> 
> Even if the final patch is unable to benefit many users, perhaps the
> process of creating that patch will still be worth it if it gives us a
> better idea of which syscalls are being used and which ones aren't.

Make such a patch, test it thoroughly and then send it here for review.

It can't be guaranteed that your patch will be accepted, but as soon as 
you'll present the patch the discussion will become more flesh.

> -Barry K. Nathan <barryn@pobox.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

