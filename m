Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263476AbTJLQEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTJLQEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:04:23 -0400
Received: from web13007.mail.yahoo.com ([216.136.174.17]:62990 "HELO
	web13007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263476AbTJLQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:04:20 -0400
Message-ID: <20031012160419.30891.qmail@web13007.mail.yahoo.com>
Date: Sun, 12 Oct 2003 09:04:19 -0700 (PDT)
From: retu <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model
To: Jamie Lokier <jamie@shareable.org>
Cc: Kenn Humborg <kenn@linux.ie>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031012115900.GC13427@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CreateProcess was to emphasize the linkage between
kernelmode and usermode and the need for the
kernelmode folks to architect the framework of the
higher layers as well. CreateProcess and its wrappers
might have been not the best choice to highlight the
point of kernspace to userspace linkage. But its set
of properties, how to set them blends with the rest of
this OO framework. 

Why not Mono or DotGNU - they pushed through a subset
of the system namespace through ECMA (a
standardization organization with little to no
discoure prior to standardization) and now believe it
or not its on ISO track. So far so good, but the rest
of the framework is closely tied to windows AND is an
IP (intellectual property) minefield. 

What's the solution out of this - a clean, open object
model designed by the core folks, extensible and free
of licensing issues - and that in the next months.  

RETU
--- Jamie Lokier <jamie@shareable.org> wrote:
> asdfd esadd wrote:
> > There is a connex, fork() might be a bad example,
> > 
> > it's simple - yes but 20 years have passed as
> Solaris
> > is finding:
> > 
> > pid_t fork(void); vs. 
> > 
> > the next step in the evolution CreateProcess
> >
> > [extraordinarily long-winded way of saying the
> same thing as
> >  if ((pid = fork()) == 0) { set_things(); go(); }
> ]
> 
> Dear asdfd,
> 
> How can you possibly think the CreateProcess
> monstrosity superior to
> fork in any way?  You seem to have picked the
> canonical example of
> just what is awful about the Win32 AI and why it's
> so much work to use.
> 
> I cannot think of a single example where
> CreateProcess is simpler to
> use - and it's worse than that: it comes with a
> bunch of assumptions
> and limitations, exactly the kind of thing that
> presumably you expect
> "a component model" to _not_ have.
> 
> What do you do when you want to create a process
> with a property that
> _isn't_ listed in the arguments to CreateProcess? 
> Yes: you have to
> set those in the child process, just like with
> fork().
> 
> So what's the point in having some of the properties
> listed in
> CreateProcess?  Answer: none.  Not from an API
> cleanliness point of
> view anyway.
> 
> > System.Object
> >    System.MarshalByRefObject
> >       System.ComponentModel.Component
> >          System.Diagnostics.Process
> > [C#]
> > public class Process : Component
> > [C++]
> > public __gc class Process : public Component
> 
> This begins to make more sense.  You do understand
> that unix has this
> class too, but it's called pid_t, not Process?
> 
> > * unified well architected core component model
> > which is extensible from OS services to
> application
> > objects
> 
> Yeah, but CreateProcess _isn't_ well architected. 
> It's among the
> worst of excreta in Win32.
> 
> > * the object model should be defined from the
> kernel
> > layer for process/events/devices etc. up and not
> > started at the application layer
> 
> Unfortunately you just state this, without giving
> any reasons for it.
> 
> If this were implemented in userspace (i.e. the Mono
> project),
> can you give a single reason why it needs to be
> extended into the kernel?
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
