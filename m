Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSIOSSV>; Sun, 15 Sep 2002 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSIOSSV>; Sun, 15 Sep 2002 14:18:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44985 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318153AbSIOSSU>; Sun, 15 Sep 2002 14:18:20 -0400
Date: Sun, 15 Sep 2002 14:23:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915142304.A21363@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> <E17qalv-0000B6-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17qalv-0000B6-00@starship>; from phillips@arcor.de on Sun, Sep 15, 2002 at 04:53:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Phillips <phillips@arcor.de>
> Date: Sun, 15 Sep 2002 16:53:15 +0200

> On Sunday 15 September 2002 08:07, Pete Zaitcev wrote:
> > > From: Daniel Phillips <phillips@arcor.de>
> > > Date: Sun, 15 Sep 2002 07:10:00 +0200
> > 
> > >[...]
> > > Let's try a different show of hands: How many users would be happier if
> > > they knew that kernel developers are using modern techniques to improve
> > > the quality of the kernel?
> > 
> > I do not see how using a debugger improves a quality of the kernel.
> 
> It improves my quality of life, that would be enough by itself. [...]
>[...]
> The answer to the question "is this sillyness slowing down development
> and reducing the quality of the kernel?" is "yes".  I don't have to
> speculate about that any more, I've seen it enough with my own eyes.
> Now ask yourself who the most productive hackers are today, and ask
> yourself if they are using the good ol zen state blunt edged tools.

OK, so you actually do not care about users getting happier.
You should have added a smilie to the quote about the show
of hands then.

The agrument about your quality of life does hold some water,
at least I do not doubt that kdb makes you and Andrew happier.
This is a wonderful thing. I do strongly suspect though, that
any gains you get on the productivity front are NOT going to
be used to improve code quality.

> Look, we tried the zen state thing.  It didn't work.  Think about the
> madness in the period between 2.3 and 2.4, with one oops after another
> reported to the list, each taking days or weeks to track down. [...]

This has nothing to do with a debugger, this is a different topic.
You actually want a crash dump analyzis tool, and so do I.
So, let's discuss that. I happen to get e-mails with oops in USB
callbacks pretty often, and they are always useless. It would be
possible to track them if off-stack memory was saved, perhaps.
However, to expect users to use debugger to collect this off-stack
information is a delusion.

This is why Red Hat stopped shipping kdb and started to ship
netdump (or so I think, anyway). It is a much more effective
tool for the crash analysis, and it can be operated by a user.
I think it beats a debugger fair and square. N.B. The data
that netdump collects may be an image to be examined by a
debugger (such as gdb), together with dedicated analysis tools.
That's entirely different debugger, so no hypocrisicy here.

-- Pete
