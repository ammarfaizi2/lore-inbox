Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277656AbRJOQWp>; Mon, 15 Oct 2001 12:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277790AbRJOQWf>; Mon, 15 Oct 2001 12:22:35 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:46037 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S277656AbRJOQWQ>;
	Mon, 15 Oct 2001 12:22:16 -0400
Date: Mon, 15 Oct 2001 17:22:43 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@red.csi.cam.ac.uk>
To: Jacques Gelinas <jack@solucorp.qc.ca>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@suse.cz>
Subject: re: Re: Announce: many virtual servers on a single box
In-Reply-To: <20011015092905.bc1c569516e5@remtk.solucorp.qc.ca>
Message-ID: <Pine.SOL.4.33.0110151718190.27087-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Jacques Gelinas wrote:
> On Fri, 12 Oct 2001 23:01:04 -0500, Pavel Machek wrote
> > Hi!
> >
> > > -I have also modified the capability system a little, so those virtual server
> > >  administrators can't take over the machine. I have introduced a per-process
> > >  capability ceiling, inherited by sub-process. Even setuid program can't grab
> > >  more capabilities..
> >
> > Really? What hardware do they see in /dev/? Do their servers have for
> > example mouse? What about ethernet cards?
>
> In /dev they see very little: full log null ptmx pts random tty
> urandom zero
>
> The do not have CAP_SYS_MKNOD, so they can't create more than you give.
>
> In fact, the vserver sees whatever you want to give it. So if you intend to run
> X in the vserver, give it the mouse device.

Hmmm - does this work with devfs?

> > [Why I'm asking? I'm trying to find ways to take over the machine. Do
> > you want to give me root on your machine stating that I can't
> > interfere?]
>
> Indeed, I could give you a root password on a vserver and you would not be
> able to interfere. Sure enough you would be able to grab resource and slow
> down the machine (and potentially work out a DOS attack). We are working
> on the schedular right now to solve those issues.

Have you looked at the "fairsched" patch for this? It seems to be
unmaintained since 2.4.0-testXX, but look close to your needs...

> But there is no need to open a crackme vserver. Install it on your machine,
> build a vserver.

The question, I think, was would YOU give out root access on vservers on
YOUR box, and be confident people wouldn't be able to escape? :-)

> > You might want to announce this on bugtraq. [And give solar designer
> > root account, he might be more creative ;)].
>
> You don't understand the issue. Anyone can create his own vserver. The
> system call controlling this are very simple. It is not a "try to
> crack my machine" contest. Anyone can create a vserver and test it.

But can you crack your way OUT of the vserver - how confident are you in
the isolation provided?


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

