Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVCCQhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVCCQhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCCQhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:37:02 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43949 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262115AbVCCQgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:36:09 -0500
Subject: Re: RFD: Kernel release numbering
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, jgarzik@pobox.com,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050303052100.GA22952@redhat.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
	 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	 <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org>
	 <20050303052100.GA22952@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 11:36:03 -0500
Message-Id: <1109867764.2908.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 00:21 -0500, Dave Jones wrote:
> On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
>  > Dave Jones <davej@redhat.com> wrote:
>  > >
>  > > On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:
>  > > 
>  > >  > I would not keep regular driver updates from a 2.6.<even> thing. 
>  > > 
>  > > Then the notion of it being stable is bogus, given how many regressions
>  > > the last few kernels have brought in drivers.  Moving from 2.6.9 -> 2.6.10
>  > > broke ALSA, USB, parport, firewire, and countless other little bits and
>  > > pieces that users tend to notice.
>  > 
>  > Grump.  Have all these regressions received the appropriate level of
>  > visibility on this mailing list?
> 
> For the most part these things are usually known about by their upstream
> authors.  To give an example: ALSA update in 2.6.10 broke sound for a
> bunch of IBM thinkpads. As it turns out there are quite a lot of these
> out there, so when I released a 2.6.10 update for Fedora, bugzilla lit
> up like a christmas tree with "Hey, where'd my sound go?" reports.
> (It was further confused by a load of other sound card problems, but
>  thats another issue).  This got so out of control, Alan asked the ALSA
> folks to take a look, and iirc Takashi figured out what had caused the
> problem, and it got fixed in the ALSA folks tree, and subsequently, in 2.6.11rc.
> 
> Now, during all this time, there hadn't been any reports of this problem
> at all on Linux-kernel. Not even from Linus' tree, let alone -mm.
> Which amazes me given how widespread the problem was.

There is not much the ALSA developers can do about this, because we just
do not have access to the 1000s of hardware varieties out there,  and
vendors are inexplicably loath to give out any docs on something as
simple as a cheap shitty laptop AC97 codec.

The usual pattern that leads to a regression like the Thinkpad issue is
that a user reports a bug, a fix is merged, the user reports the problem
is fixed on $FOO hardware, then a week later we are deluged with reports
that $BAR hardware is now broken.

Catching a problem like this before it gets out the door would require
access to 1000s of laptops, unlimited time, and reasonable hardware
documentation.  Chances are we would still miss something.  IOW it's
impossible.

The *only* solution for these kinds of driver regressions is to get more
people to test the release candidates.  "Being more careful" will not
help, because we just don't have access to all of the hardware.

Lee

