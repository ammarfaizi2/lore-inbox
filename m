Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUB2OtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUB2OtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:49:14 -0500
Received: from zadnik.org ([194.12.244.90]:50397 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262053AbUB2OtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:49:07 -0500
Date: Sun, 29 Feb 2004 16:48:46 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <m365dqoym3.fsf@zoo.weinigel.se>
Message-ID: <Pine.LNX.4.44.0402291642560.3431-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Feb 2004, Christer Weinigel wrote:

> Grigor Gatchev <grigor@zadnik.org> writes:
>
> > > In the linux kernel I think that one of the most important things I've
> > > learned from it: middle layers are usually wrong.  Instead of hiding a
> > > device driver behind a middle layer, expose the low level device
> > > driver, but give it a library of common functions to build upon.  That
> > > way the driver is in control all the time and can use all the neat
> > > features of the hardware if it wants to, but for all the common tasks
> > > that have to be done, hand them over to the library.
> >
> > By principle, the "least common denominator" type container layers are
> > bad, because of not being extendable; you are completely right here. A
> > class-like driver object model seems better to me. And the class-like
> > model is not the only one that is nicely extendable.
>
> > You seem to be knowledgeable on the topic - what driver object model
> > would you suggest for a driver layer model?
>
> Thanks for the confidence, bur I really don't know, it's much easier
> to criticize someone elses design than to come up with a good one
> myself. :-)

Okay. I will try (hope I'll have the time for all!) to outline the major
driver layer models, with simple lists of advantages and disadvantages,
and to present it as a base for further discussion. (Please keep in mind
that this outline will certainly be not the best ever to exist - maybe a
lot of people around will be able to make it much better. But, anyway,
they will be given the full opportunity to criticize and improve. :-)

> With that said, I think that they way the Linux kernel is moving
> regarding to IDE/SCSI devices is a good idea.  Linux has been around
> for a while now and the Linux people have tried lots of things that
> turned out not to be such a good idea after all.  Many things are
> still there in the kernel, but if it's important enough, it gets
> cleaned up after a while.

If you mean the abandoning of the SCSI emulation, I couldn't agree more.
Though I haven't digged into the code of this driver group, the move seems
only logical from design viewpoint.


