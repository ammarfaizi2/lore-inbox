Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUIMGGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUIMGGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUIMGGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:06:20 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:16182 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266127AbUIMGF4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:05:56 -0400
Message-ID: <a728f9f9040912230544dcf8df@mail.gmail.com>
Date: Mon, 13 Sep 2004 02:05:56 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: radeon-pre-2
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 20:45:18 -0400 (EDT), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> 
> 
> On Sun, 12 Sep 2004, Michel [ISO-8859-1] D�nzer wrote:
> 
> > On Sun, 2004-09-12 at 23:42 +0100, Dave Airlie wrote:
> >>
> >> I think yourself and Linus's ideas for a locking scheme look good, I also
> >> know they won't please Jon too much as he can see where the potential
> >> ineffecienes with saving/restore card state on driver swap are, especailly
> >> on running fbcon and X on a dual-head card with different users.
> >
> > Frankly, I don't understand the fuss about that. When you run a 3D
> > client on X today, 3D client and X server share the accelerator with
> > this scheme, and as imperfect as it is, it seems to do a pretty good job
> > in my experience.
> 
> Not that good - try dragging something while a DVD video is playing.

The overlay could be converted to use the CP engine as well. right now
it has to switch to MMIO for overlay.

Alex

> 
> But, I don't understand what the fuss is about either. What's wrong with
> putting PLL setting code inside DRM driver and letting it be the client of
> fbcon ? And the transition problems could be well solved by leaving the
> existing fbcon in for the time being, it is not like the kernel does not
> have duplicate drivers.
> 
>                       best
> 
>                         Vladimir Dergachev
> 
> 
> 
> >
> >
> > --
> > Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
> > Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> > Project Admins to receive an Apple iPod Mini FREE for your judgement on
> > who ports your project to Linux PPC the best. Sponsored by IBM.
> > Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> > --
> > _______________________________________________
> > Dri-devel mailing list
> > Dri-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/dri-devel
> >
>
