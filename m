Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSBITqV>; Sat, 9 Feb 2002 14:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSBITqM>; Sat, 9 Feb 2002 14:46:12 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:8191 "EHLO fep3.cogeco.net")
	by vger.kernel.org with ESMTP id <S285417AbSBITp5>;
	Sat, 9 Feb 2002 14:45:57 -0500
Subject: Re: Continuing /dev/random problems with 2.4
From: "Nix N. Nix" <nix@go-nix.ca>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Robert Love <rml@tech9.net>, Roland Dreier <roland@topspincom.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020206105208.7298B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020206105208.7298B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Feb 2002 14:45:13 -0500
Message-Id: <1013283914.6628.6.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-06 at 11:16, Bill Davidsen wrote:
> On 5 Feb 2002, Robert Love wrote:
> 
> > On Tue, 2002-02-05 at 18:02, Bill Davidsen wrote:
> > 
> > > You seem to equate root space with user space, which is a kernel way of
> > > looking at things, particularly if you haven't been noting all the various
> > > hacker attacks lately. Just because it is possible to run in user space
> > > doesn't mean it's desirable to do so, and many sites don't really want
> > > things running as root so they can feed other things to the kernel.
> > > 
> > > The assumption that power users will know how to fix it and other users
> > > won't notice they have no entropy isn't all that appealing to me, I want
> > > Linux to be as easy to do right as the competition.
> > 
> > It is certainly desirable to run as much as feasibly possible in
> > userspace.  The only exception of things that could be handled in
> > userspace but are allowed to live in kernel space would be performance
> > critical and stable items (say, TCP/IP).
> 
>   Given that there is graphics stuff in there, and web server stuff, I
> would say that having the system hang waiting for entropy is a performance
> issue. And lack of it is a security issue.
>  
> > No one said the rngd has to run as root.  For example, run it as nobody
> > in a random group and give /dev/random write privileges to the random
> > group.
> 
>   So a functional /dev/random would be a feature of power users installing
> fixes, as opposed to the kernel using the available hardware? And having
> one or more extra user space daemons crapping up the system doesn't seem
> an issue?
>  
> > If userspace equates to insecure, and we stick things in the kernel for
> > that reason, we are beyond help ...
> 
>   Not all Linux users are hackers, and depending on users to know their
> hardware, find, build, install, and configure something, change ownership
> of a device without messing it up, and understand that not doing so is
> both a performance and security issue... seems either optimistic or just
> unconcerned with the users. 

What about distributors ?  These user space daemons and device ownership
changes can be done by the installation process of any given distro.  I
know Mandrake allows users to choose their "security level" from
install.  The options range from "Welcome to crackers" to "Paranoid". 
I'm certain that distros could perform the proper steps upon detection
of, say, a RNG.

> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


