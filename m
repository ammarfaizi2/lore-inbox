Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJKR4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJKR4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:56:14 -0400
Received: from web13002.mail.yahoo.com ([216.136.174.12]:25438 "HELO
	web13002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263343AbTJKR4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:56:12 -0400
Message-ID: <20031011175611.16214.qmail@web13002.mail.yahoo.com>
Date: Sat, 11 Oct 2003 10:56:11 -0700 (PDT)
From: asdfd esadd <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model 
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200310111738.h9BHcB6s027943@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's exposing many of the syscalls into relevant
user-space objects which makes the other OSs approach
neat. Coming from the kernel an outline of a common
object model should be suggested which is then
actually populated and refined futher by e.g. the GUI
folks. 

The other way around has shown not to work with the
many application-designed component frameworks out
there. In the other OS you'll be able to do things in
I/O, process, GUI, data access etc. in a quite similar
way. The current permutation in Linux for putting
together an application is staggering, which can force
people to use the lowest common denominator - like
libc.a ;) - it's actually not funny.   

A core component model has to be defined by the kernel
group and then trickle upward. That's the only way
where you can sufficiently design in performance and
security(*) considerations which I agree should allow
Linux to scale as well as it does. 

  
(*) good example for the opportunity in leaping the
other OS here: there is another big void in a sound
security component properties right now. COM+ has
quite a bit in it, but there is much more which could
be done and people are keen on it. Another item where
Linux could start to define the envelope. 
 

--- Valdis.Kletnieks@vt.edu wrote:
> On Sat, 11 Oct 2003 10:13:55 PDT, you said:
> > 
> > unfortunately it's rather a jump into elegance.
> The
> > other OS component model is quite well
> architected.
> > Hence what's needed is _a similar architecture
> effort
> > which may _abstract many things in the beginning
> to be
> > filled in later. Ther's a dire need for a sound
> and
> > similarly elegant (or better) model. 
> 
> Two words: "syscall interface".
> 
> Most of what you're blathering about needs to happen
> in userspace.
> 
> If there's disagreement over what GUI style to use,
> the kernel is
> NOT going to provide any guidance.  KDE versus Gnome
> versus the
> other 23 window managers - that's all userspace. 
> The reason there's
> 25 window managers is because 25 sets of people had
> *different goals*.
> 
> The kernel wisely stayed *OUT OF THE WAY*.
> 
> With a single common object model, Linux can push
> the envelope in ONE
> direction.  Which is why That Other System scales so
> incredibly well from
> a Zaurus to a 128-CPU NUMA box, handles different
> GUIs for different goals,
> and all the rest of that.....
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
