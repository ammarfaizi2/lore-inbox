Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRIJJgu>; Mon, 10 Sep 2001 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRIJJgb>; Mon, 10 Sep 2001 05:36:31 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:7182 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269779AbRIJJgT>; Mon, 10 Sep 2001 05:36:19 -0400
Message-ID: <3B9C8957.A01DDFD9@t-online.de>
Date: Mon, 10 Sep 2001 11:35:19 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rvandam@liwave.com
CC: linux-kernel@vger.kernel.org
Subject: Re: FW: OT: Integrating Directory Services for Linux
In-Reply-To: <001501c1398f$5bb85c40$1f0201c0@w2k001>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Van Dam schrieb:
> 
> Frank Schneider:
> >>1.) Why add an extra-DS-System to the existing ones ?
> >>We have OpenLDAP, NDS (going down), ADS (going up, pushed by MS) and
> >>NIS+ out there, plus things like X.500 or how they are called. Currently
> >>Linux can work with most of them except ADS, AFAIK (better or worse with
> >>some, but it can)
> >>Why re-invent the wheel a 4th or even 5th time ?
> 
>  Using ADS or NDS is not a good solution, because in my opinion, it would be
> dependent on a another OS. 

Thats true, but imagine the following:
A company wants to switch from W2k to Linux (a case that will happen in
the future quite often, i hope).
What will be better, first only switching the OS (because Linux can
"talk" ADS or OpenLDAP), and in a second task switching the DS-service
(from ADS to OpenLDAP or whatever) or switching both at once ?
I think you would have enough to do in convincing the management of the
first solution...but the second one will most likely be dropped because
of the fear that the whole company cannot work anymore...:-)

The problem is at the moment, that every DS-structure wants to gain
access of the "core-tasks" like AAA (Authentication, Authoriasation,
Accounting), MS is pushing this because they think when their OS sits in
the middle, all the other servers have to move to W2k too.
Novell and OpenLDAP are likely doing the same, without the marketing
perhaps (OpenLDAP), but the target is also clear.

Why then move linux in a battle around these core-tasks by building an
owne DS-system ?
I would say that the way "we can replace it, and we are more stable,
cheaper and easier to manage" would be the better way.

> I would rather have the DS maintained on a
> OpenSource OS. 

This is a good start, but then we would have to ask us why we do not
increase support for OpenLDAP instead of rolling our own...


> NIS+ is basically obsolete. 

Dont say this...its the only way to get nearly all UNICEs into one
system...SUN can do OpenLDAP, like Linux, but HP-UX cant...if you have
HP-UX-Workstations, your only way is NIS(+)...

> OpenLDAP could be turned into a
> workable solution, but there is no "consistent" bridge between OpenLDAP and
> Linux. For instance if you want to manager user accounts with it you need
> PAM, and unfortunately PAM isn't compatible with a lot of userland
> applications and services.

But PAM is running quite long now, and i think it has a good structure
and is expandable...if the apps cannot work with PAM, we should change
the apps....and not throw away PAM...PAM is one of the things were Linux
is ahead of others...i can switch the authentication on my linuxbox from
/etc/passwd to an NT-Domaincontroller...AFAIK this can only linux (or
*BSD?)
 
> In my opinion, I don't see any way for directory services to become a fully
> enabled tool without full support from all of the major Linux development
> groups. I believe its going require a lot of effort to to make it a reality.

Ok, but building an own DS-system would be an effort too, or ?

> I don't think DS will work unless there some standard for DS established by
> the core linux development groups. Another words, what I would like have is
> the framework for a standard for implemeting DS for Linux.
> 
> >> I think these DS-Systems are really a part of userland, and the
> >>kernel itself should never mess around with high-level-security issues
> >>like Access Controll Lists or such things...this is the job of
> >>userlandtools.
> 
> Agreed, the database any other tools can be done in userland and should be.
> I started this discussion to see if anyone out there considers DS important
> for Linux growth.  I am not sugguesting that this should be in the kernel.
> Just some sort of directory system that can manage configurations of a large
> number of linux boxes.

BTW, there is already a tool to manage various *X-boxes...its called
"VENUS", but i do not know the manufacturer in the moment...my company
uses this, and it can do quite a lot...it depends on NIS.

(...ACL in Kernel..)
 
> How would you manage 1000 or 10,000 desktop boxes each with their own /etc
> directory?  Imagine your supporting several hundred or even several thousand
> unix boxes, and you need to apply a standard change to all of them. Lets
> also assume your not getting paid by the hour, or you need to get the change
> done in just a hour or two. 

Have a look at this VENUS-system, it can do this...and it can do this
across various *X-plattforms, and thats a point we also have to keep in
mind: We as linux will have always other *X beside us, and therefore we
should have a eye not only on the Win-side, but also on the *X-side...

Would you trust a running a script on a
> /etc/*.conf file to apply a change on your boxes? I suppose if you really
> like to torture yourself, you could modify each of those files by hand,
> ouch!

Ok, i did not run scripts over linux-boxes, but i ran scripts over some
hundred network-components (cisco switches) and it always worked for
me...but it is a risk, thats clear, but if you get 80-90% done with a
script, and the rest by hand, it is a success...trying to get 100% with
one script/solution is a kind of dreaming IMHO...
 
Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
