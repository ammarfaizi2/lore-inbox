Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271729AbRHUQOb>; Tue, 21 Aug 2001 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271731AbRHUQOW>; Tue, 21 Aug 2001 12:14:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:50135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271729AbRHUQOH>;
	Tue, 21 Aug 2001 12:14:07 -0400
Message-ID: <3B8288DA.D5E52766@gmx.at>
Date: Tue, 21 Aug 2001 18:14:18 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
			<m166bjokre.fsf@frodo.biederman.org>
			<20010819214322.D1315@squish.home.loc>
			<m1snenmfe0.fsf@frodo.biederman.org>
			<20010820211410.B218@squish.home.loc> <m1g0amlzcm.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Paul <set@pobox.com> writes:
> 
> > "Eric W. Biederman" <ebiederm@xmission.com>, on Mon Aug 20, 2001 [12:09:27 AM]
> > said:
> >
> >
> > > If you can rule out X stracing dosemu might be of some help.   The
> > > challenge now is to track down what dosemu is doing that is triggering
> > > the problem.
> > >
> > > As an interrupt handler is where the oops is occuring.  Finding an
> > > immediate cause and effect could be tricky.
> > >
> > > Eric
> >
> >       Dear Eric;
> >
> >       Ok. I oopsed/locked the machine running 'dos' in a vt,
> > without X in single user mode. Then I did it again, stracing the
> > session.  Unfortunately, the fs was left in such a state, that
> > fsck completely chucked the logfile out. Then I booted 2.2.18, and
> > tried.  I could not make it oops.
> >       I need to setup a test machine to persue this farther, as
> > locking and fscking my main box is no fun:) Ill try to get that
> > strace...
> 
> O.k.  That rules out all kinds of things.  What is interesting at first
> glance is that a) Every oops has been in an interrupt handler. and
> b) It is never remotely at the same location.
> 
> I'm beginning to suspect there is some kind of hardware problem.  But it
> is very weird.  I wonder if dos 6.2 somehow tickles a bug in the media GX
> processor.  Though my top canidate is probably the lazy state switching
> introduced in 2.4.  I know there were some problems with the ldt that were
> fixed, and there might be another case out there.  But I'm just guessing
> in the dark.
> 
> If you can reproduce this on a second machine that would definentily help.
> 
> Eric

I have the same problem on a K7-800. My kernel is 2.4.7-ac3 (with K7
optimization!). Everything else seems to work fine, but dosemu locks up
the computer when running certain games.
Sometimes I can play for quite some time (1/2 hour or more) without
problems. Eventually it will freeze. It feels like it is triggered by
mouse activity.

Wilfried
