Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUDHEIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 00:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUDHEIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 00:08:20 -0400
Received: from web40508.mail.yahoo.com ([66.218.78.125]:58961 "HELO
	web40508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261576AbUDHEIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 00:08:04 -0400
Message-ID: <20040408040756.95337.qmail@web40508.mail.yahoo.com>
Date: Wed, 7 Apr 2004 21:07:56 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404080243.i382hG6K003775@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> 
> [...]
> 
> > > And then there is the technology of _inventing_
> a
> > > language tailored to the
> > > task at hand... even better than your list of
> > > high-level languages.
> 
> > I started exactly with that. I found out shortly
> that
> > have no idea of functionality needed for such kind
> of
> > system.
> 
> Come back when you have found out.

Sorry. I live in the real world. In 1999 I had servers
to protect. One of them was hacked and I started to
look for tools which could protect servers. I found
NOTHING. (there were some Intrusion Detection Systems,
which would alert you when your server was ALREADY
hacked - it was completely unacceptable for me).

So I created VXE. Problem was solved. I could not sit
and think about some perfect design while my servers
were in the net unprotected, it's too expensive.

Speed is not most important for me. If I have fast but
unprotected server - it is of no use for me.

> 
> >         It was clear that requirments for this
> sytem
> > can change rapidly.
> 
> I would not trust anything with "rapidly changing
> requirements" as security
> infrastructure.

VXE worked for me. It was much better than nothing.

> >                     Only general purpose language
> can
> > address this problem (if we want to save time of
> > development and introduction of new security
> models).
> 
> A security model has to be exhaustively scrutinized,
> proved correct and
> complete, and well-tested. The implementation
> language is completely
> irrelevant, the hard work is _not_ programming.
> 
> > Example. Current security policies are 'static'.
> 
> In what sense?

Actually one 'dynamic' feature is implemented in VXE.
In ordinary system resource has permissions which
allows access or not. For higher security VXE can
count number of allowed accesses. For example, we are
securing POP server. We allow it to open /etc/passwd,
/etc/shadow for reading only once (counter is 1). So,
if hacker breaks to POP server after it opened
/etc/passwd - there is no way hacker can open this
file.

Another 'dynamic' feature is changing policy on the
fly. For now POP server can access all mailboxes in
/var/spool/mail - it's easy to add ability to modify
policy. After POP server authorized user it changes
it's UID - at that point we can set access to
/var/spool/mail/user_1 only. So POPD couldn't access
other files in all mailbox directories.

> >                                                 
> It
> > seems, that it would be nice to have 'dynamic'
> > policies (with support from security model).
> 
> Again, what does this mean?
> 
> >                                              Now,
> > policy describes resources available for
> subsystem.
> 
> No...
> 
> >                                                   
>  It
> > may be useful to limit the sequence of access to
> > resources - 'behaviour' of subsystem. I'm not sure
> if
> > I want to implement that right away, but there is
> > commercial system which does exactly that already
> (it
> > was created later than VXE).
> 
> What is the use of restricting access sequences? If
> sequence A, B, C is
> forbidden, chances are that C, B, A (or any of the
> other 4 permutations)
> will give an attacker exactly what he wants.

VXE can have counters assigned to syscall parameters.
More sophisticated way is to have determined sequence
of syscalls. So, if hackers broke in the system
(sendmail for example) he can just follow logic of the
system - do the work of sendmail for you :-)

I can't say how easy to use this, but the company (my
competitors :-) which created this is entercept.com -
it seems, that they were very successful - I went to
their site right now and was redirected to Network
Associates - they were bought out, my guess. 

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
