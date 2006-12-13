Return-Path: <linux-kernel-owner+w=401wt.eu-S1750949AbWLMVDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWLMVDd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWLMVDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:03:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41443 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbWLMVDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:03:32 -0500
Date: Wed, 13 Dec 2006 13:03:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael K. Edwards" <medwards.linux@gmail.com>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612131259260.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Michael K. Edwards wrote:
>
> On 12/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > Ok, what kind of ass-hat idiotic thing is this?
> 
> C'mon, Linus, tell us how you _really_ feel.

I'll try to be less subtle next time ;)

> Seriously, though, please please pretty please do not allow a facility
> for "going through a simple interface to get accesses to irqs and
> memory regions" into the mainline kernel, with or without toy ISA
> examples.

I do agree.

I'm not violently opposed to something like this in practice (we've 
already allowed it for USB devices), but there definitely needs to be a 
real reason that helps _us_, not just some ass-hat vendor that looks for a 
way to avoid open-sourcing their driver.

If there are real and valid uses (and as mentioned, I actually think that 
the whole graphics-3D-engine-thing is such a use) where a kernel driver 
simply doesn't work out well, or where there are serious tecnical reasons 
why it wants to be in user space (and "stability" is not one such thing: 
if you access hardware directly in user space, and your driver is buggy, 
the machine is equally deal, and a hell of a lot harder to control to 
boot).

Microkernel people have their heads up their arses, none of their 
arguments have actually ever made any real logical sense. So look 
elsewhere for real reasons to do it in user space.

		Linus
