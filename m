Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUJRB4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUJRB4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 21:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269351AbUJRB4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 21:56:17 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:64092 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269347AbUJRB4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 21:56:10 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Mn3HGUPOMexbokVXLj9rcBv/FmYPMOk+IUbWTJeF/R8e6oCppHmWaOSVy1yxF8Vbb3vsAEIDvmhCjhaVKfpHX/apPAhywaeqFJa6a/aXUrn0t/9LCLm3TvrIaPMb6OsOAhLDZ2ovmYl8aN59aevQ7Ir19SqInt5WJRDFL5G8l64
Message-ID: <35fb2e5904101718565aacaf64@mail.gmail.com>
Date: Mon, 18 Oct 2004 02:56:09 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: root@chaos.analogic.com
Subject: Re: Fw: signed kernel modules?
Cc: David Howells <dhowells@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0410141357380.877@scrub.home>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <27277.1097702318@redhat.com> <17271.1097756056@redhat.com>
	 <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 09:08:27 -0400 (EDT), Richard B. Johnson
<root@chaos.analogic.com> wrote:
> On Thu, 14 Oct 2004, David Howells wrote:
> 
> >
> > > I'm trying to understand the reason to stuff this into kernel. Why can't
> > > this check be done before loading the module into the kernel? If you don't
> > > trust insmod, how can you trust the build system?
> >
> >  (1) insmod isn't the only way to load a module.
> >
> >  (2) This helps limit what an intruder can do; particularly if you combine it
> >      with other measures.
> >
> >  (3) Who says the kernel RPM is built on the same machine as the one you
> >      really want to deploy this on for the added protection?

> I think I smell something.  We had a perfectly-good way of loading
> modules. About 99 percent of the code was in user-space. Now, 99 percent
> of the code is in the kernel. Why? I think this is to "prove" that
> kernel modules are "kernel" things that require kernel licensing.

The only extent to which I'll agree you have half a point - is in the
fact that the kernel does have to worry more about licensing issues
these days. I think it's plain crazy and delusional to suggest that
there is a secret lawyer driven motive behind the 2.6 implementation
however. That said, I've not taken my anti-brain rays tablet yet today
so that might just be what they want me to think.

> The new build system sucks. The new kernel module loading scheme
> sucks, pure and simple. In fact, Linux is degenerating into
> a trash bin of "me-too" hacks.

What sucks about it? That you didn't bother to read about how to use
it, or that it's fundamentally got some problem you can offer a
solution to?

> I am now back to Linux-2.4.26 after trying to run a new standard
> distribution of "Red Hat Fedora" on a completely separate
> hard-disk. I had to rebuild everything for the third time
> (reinstall all software) and I'm thoroughly pissed. The
> Linux-2.6.whatever that comes with that garbage trashes my
> SCSI disks if I mount them, making them unusable and
> requiring a complete reinstall of everything.

This isn't a Fedora discussion list. Several folks here work for
RedHat but that's not an excuse for having a Fedora rant here. If you
dislike what you downloaded - go buy a supported product and call tech
support.

> The new kernel build environment is also corrupt. On
> this system, it takes 45 seconds to perform:
> 
> make clean
> make bzImage
> 
> With the new build system, same disk, same kernel
> configuration, it takes 14 minutes. And, you can't
> even see what the compiler doesn't like.

Geert suggested a quick fix for displaying the compilation process. I
admit that I didn't like not seeing the compiler output on first use,
but then you grow used to the newer build process and come to like it
- and can always read through the Makefiles to trivially figure out
how to display the compiler output. The 14 minute claim reeks with
some feeling of an alternative reason - perhaps you're doing this on a
box with some weird symlink to a dying nfs server or goodness knows
what, some more information would help debugging.

> The build system generates separate command-files,
> hidden from `ls` by having them start with ".", for
> every source-file and link action, plus it even
> makes hidden subdirectories.

Oh no! We'd better call the Microsoft police in to fix this and make
it all ok again. How will we all cope having to give additional flags
to ls? Can't you remember all 26 flags off the top of your head
anyway? ;-)

> The modules build
> even generates its own 'C' source-file for some
> junk that the new `insmod` needs. It's crap, pure
> and simple. Damn crap. All of it.

Right. We'll need to be throwing away the dummy.o stages and a lot of
other kernel code too then. Looks like it's all crap according to you
so no big loss - meanwhile, in the real world, the kernel build
process has used cunning hacks for years. As long as they're more
cunning than a cunning fox, it's all ok.

> This is the best example of technological degeneration
> I've seen in my 40+ years of professional involvement
> in engineering. Somebody may write a book and the
> only fame that will remain will be visual impact
> of a smoking hole that was once a viable operating
> system borne on the ideas of thousands world-wide.

Let's get this right: you get fed up with Fedora didn't you? So you
decided that all the kernel hackers must be part of a secret lawyer
driver conspiracy to create an evil build system that's out to get
you? Cool.

> I qoute; "Have you no shame?"

I have enough to take the flamebait all the way. Sorry folks.

> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.

Still, not bothered and bitter enough to not have the above tagline.
Look at me! I've got a big processor!

Jon.
