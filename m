Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316776AbSEUXUV>; Tue, 21 May 2002 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSEUXUU>; Tue, 21 May 2002 19:20:20 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:24966 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S316776AbSEUXUS>;
	Tue, 21 May 2002 19:20:18 -0400
Date: Tue, 21 May 2002 19:20:19 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Kevin Buhr <buhr@telus.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lazy Newbie Question
In-Reply-To: <87y9edfcav.fsf@saurus.asaurus.invalid>
Message-ID: <Pine.LNX.4.33L2.0205211917110.16426-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2002, Kevin Buhr wrote:

> "Calin A. Culianu" <calin@ajvar.org> writes:
> >
> > Get comedi-cvs.
>
> Thanks.
>
> > > > 'nuff said.
> > >
> > > On the contrary...
> >
> > Yeah whatever.
>
> Well, as you can see from the implementation of "comedi_open" that's
> right in front of you, that code doesn't do anything with the filename
> except parse it as string of the form "/dev/comediNNN" to get the
> minor number "NNN".  It looks like a cheesy hack to fake the
> kernel-mode interface to look like the user-mode interface, but that's
> all it is.  So, as Richard said, we still haven't seen any evidence
> that Comedi requires manipulating files in kernel space.
>
> It's quite strange how rude and evasive you're being when everyone
> who's replied has been polite and helpful.  Perhaps if you lost the
> attitude and told us what it is you're really trying to do, we could
> help you more effectively.
>
> I mean, either we're all too dim to understand your device driver
> hacking skills, in which case there's no point in you wasting your
> time here, or one of us has enough of a clue to help, in which case
> we'd all benefit from you explaining your problem as fully as you are
> able instead of demanding we show you how to do the impossible (i.e.,
> stat a file without a process context).

What the fuck is your problem?  I was merely wondering how to use
path_init/path_walk.  I had to go to the newbie irc channel and they were
much politer and must more helpful.  None of this fucking attitude of "why
do you want to do that that is evil never do that".  Obviously i have a
reason to do it and I don't need you lecturing me.


> By the way, in case you missed it---and it seems you did---Richard
> already gave you the right answer in the message you mistakenly
> dismissed as a flame.  If you really need to stat a file from the
> kernel, you do this with a helper process in the form of a bona fide
> user process or a kernel thread.  Because this is relatively
> complicated to get right (there's a damn good reason the code in
> "comedi_open" just fakes it), you don't want to do this unless you
> have to.

Well I lack the knowledge to do that.  Can you be a bit more specific as
to code examples or whatnot?  Just being vague and saying "you don't need
to do that" is bad.

Anyway I am doing it from module_init() in a module I am writing, so the
current thread context is pretty much a good one.

-Calin


