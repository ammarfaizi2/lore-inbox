Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269589AbUICK6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbUICK6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbUICK6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:58:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:57029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269589AbUICK6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:58:08 -0400
Date: Fri, 3 Sep 2004 12:43:46 +0200
From: Greg KH <greg@kroah.com>
To: Grzegorz Ja??kiewicz <gryzman@gmail.com>
Cc: Helge Hafting <helge.hafting@hist.no>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040903104346.GA7867@kroah.com>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <200408290004.i7T04DEO003646@localhost.localdomain> <20040901224513.GM31934@mail.shareable.org> <20040903082256.GA17629@kroah.com> <2f4958ff04090301326e7302c1@mail.gmail.com> <41383142.4080201@hist.no> <2f4958ff04090302141bc222e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4958ff04090302141bc222e5@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 11:14:51AM +0200, Grzegorz Ja??kiewicz wrote:
> On Fri, 03 Sep 2004 10:54:26 +0200, Helge Hafting <helge.hafting@hist.no> wrote:
> > Grzegorz Ja??kiewicz wrote:
> > 
> > >
> > >devfs was very natural, and simple solution. But to have it right, it
> > >would have to be the only /dev filesystem.
> > >But no, we like choices, so we have chaos.
> > >Udev is just another thing adding to that chaos.
> > >
> > >Someone was numbering things that are good in BSD design, in that
> > >thread. One of those things was going for devfs. No cheap solutions.
> > >One fs for /dev. And it works great.
> > >
> > >Sorry for bit of trolling.
> > >
> > >
> > Devfs was a ver good idea.  The implementation of it
> > was a problem, and after some time nobody maintained it.
> > No surprise it had to go.  Now udev+tmpfs can do the same
> > job, and more.
> 
> udef is a one big mistake, having need for userspace tool to use FS is
> at least silly.

I have never heard of a program called "udef".  Any pointers to it?  :)

If it's such a big mistake, then don't use it.  No one is forcing you
to.

> I can understeand need for some things in kernel to have userspace
> daemon. But FS is out of question the least one.

It's not a daemon (although to make things a bit easier on itself, it
does provide one by default, but some distros don't use it.)  It just
creates device nodes when the kernel finds a new device, with a name
that you pick.  Which is something that an in-kernel devfs can not do.

> I am supprised noone wanted to maintain devfs. Maybe because people
> didn't want to go to devfs only. But still to have classic /dev. It's
> also silly, because person writing driver needs to choose between, or
> implement all. That's more than bad. Once I have loads of time, and no
> work in KDE, I can take over devfs happily :-)

Well, until you do that, baseless criticism and trolling like this will
be ignored.

greg k-h
