Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbRLNUli>; Fri, 14 Dec 2001 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285499AbRLNUla>; Fri, 14 Dec 2001 15:41:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285498AbRLNUlN>; Fri, 14 Dec 2001 15:41:13 -0500
Date: Fri, 14 Dec 2001 12:40:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Simon Kirby <sim@netnation.com>
cc: <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <20011214123628.A22506@netnation.com>
Message-ID: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Dec 2001, Simon Kirby wrote:
>
> On Fri, Dec 14, 2001 at 05:34:48PM +0000, Andries.Brouwer@cwi.nl wrote:
>
> > + * POSIX (2001) specifies "If pid is -1, sig shall be sent to all processes
> > + * (excluding an unspecified set of system processes) for which the process
> > + * has permission to send that signal."
> > + * So, probably the process should also signal itself.
> > -			if (p->pid > 1 && p != current) {
> > +			if (p->pid > 1) {
>
> Argh, I hate this.  I fail to see what progress a process could make if
> it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
> everything except my shell, and now I'll have to kill everything else
> manually, one by one.

I do agree, I've used "kill -9 -1" myself.

However, let's see how problematic it is to try to follow it (in 2.5.x,
not 2.4.x) and if people really complain.

Count one for the complaints, but I want more to overrule a published
standard.

(Of course, a language lawyer will call "self" a "system process",
although I cannot for the life of me really see what kind of excuse we
would come up with to do se ;)

		Linus

