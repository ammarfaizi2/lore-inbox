Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRK1Tqk>; Wed, 28 Nov 2001 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280495AbRK1Tpo>; Wed, 28 Nov 2001 14:45:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57095 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280524AbRK1Tp2>; Wed, 28 Nov 2001 14:45:28 -0500
Message-ID: <3C053EA8.68BD3613@zip.com.au>
Date: Wed, 28 Nov 2001 11:44:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kamil Iskra <kamil@science.uva.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <3C03CEFB.780622F1@zip.com.au> <Pine.SOL.4.30.0111282007440.26732-100000@carol.wins.uva.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil Iskra wrote:
> 
> On Tue, 27 Nov 2001, Andrew Morton wrote:
> 
> > I don't understand what can be causing the behaviour which you
> > report.  Presumably, some application is generating disk writes,
> > and kjournald is thus performing disk IO every five seconds.
> 
> The only such "application" could be syslogd or apmd.  There is virtually
> nothing more running in single user mode.
> 
> > If possible, could you please edit fs/jbd/journal.c and change
> >
> >       journal->j_commit_interval = (HZ * 5);
> > to
> >       journal->j_commit_interval = (HZ * 30);
> 
> Just tried it.  Unfortunately, it didn't improve anything.  Consistent
> failure what doing "apm -s".  I tried some 15 times or so in single user
> mode.
> 
> Should you, or anybody else, have further suggestions, I'll be happy to
> try them out.

I'm stumped. Sorry.  I was hoping Alan would leap in with
words of revelation.

Maybe you can turn on APM debugging with `apm=debug' on the
LILO command line, or `modprobe apm debug=1', see if that
provides a hint.  APM debug mode doesn't seem to do much though.

-
