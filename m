Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312787AbSCVSYu>; Fri, 22 Mar 2002 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312788AbSCVSYk>; Fri, 22 Mar 2002 13:24:40 -0500
Received: from [209.58.5.130] ([209.58.5.130]:7892 "EHLO smtp.discreet.com")
	by vger.kernel.org with ESMTP id <S312787AbSCVSY0>;
	Fri, 22 Mar 2002 13:24:26 -0500
Message-Id: <200203221824.NAA5677457@cuba.discreet.qc.ca>
Content-Type: text/plain; charset=US-ASCII
From: Martin Blais <blais@discreet.com>
Organization: Discreet Logic
To: Pavel Machek <pavel@ucw.cz>, Martin Blais <blais@IRO.UMontreal.CA>
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Date: Fri, 22 Mar 2002 13:19:40 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <20020322092712.GA233@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 March 2002 04:27, Pavel Machek wrote:
> Hi!
>
> > I actually wanted to implement it exactly like this in xxdiff,
> > and I think it may not be too hard. Something like
> >
> >   "xxdiff --patch file1 < patch"
> >
> > and it would display as two files, and allow you to save merged
> > results. That was the plan (read more below).
> >
> > I wanted to spawn a patch command on it and recuperate the
> > output and then run diff and display that, so one could use and
> > alternate patch program as well, and I would reuse patch's
> > heuristics automatically (e.g. i don't have to code it myself).
>
> ... but ...
>
> > > Neil Brown agreed with this, and said, "I would like a tool
> > > (actually an emacs mode) that would show me exactly why a patch
> > > fails, and allow me to edit bits until it fits, and then apply
> > > it. I assume that is what you mean by "wiggle a patch into a
> > > file"." Pavel Machek also thought this would be a rerally great
> > > thing.
> >
> > The part I haven't figured out a nice solution for yet, is for
> > the failed hunks... how to display them sensibly.  I was
> > thinking of using the 3-file display with the third file
> > showing only the failed hunks in the approximate location where
> > they were supposed to be. Not sure how to do this yet. Any
> > ideas welcome.
>
> It would be great to somehow split patches before feeding them to the
> patch. If you have one big hunk, and it fails because of one letter
> added somewhere in file, it is *big pain* to find/kill offending
> letter.

i though patch did that by itself, by attempting to merge per-hunk, and that 
it saved all the failed merges in a reject file (file.rej). or perhaps 
i'm missing something. isn't it the case?

(note that i don't have much experience using patch itself)
