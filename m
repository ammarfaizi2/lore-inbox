Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRAPO2v>; Tue, 16 Jan 2001 09:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbRAPO2m>; Tue, 16 Jan 2001 09:28:42 -0500
Received: from felix.convergence.de ([212.84.236.131]:64522 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129601AbRAPO2Y>;
	Tue, 16 Jan 2001 09:28:24 -0500
Date: Tue, 16 Jan 2001 15:27:56 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
Message-ID: <20010116152756.B32180@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 10:48:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Ingo Molnar (mingo@elte.hu):
> But even user-space code could use 'native files', via the following, safe
> mechanizm:

[something reminiscient of a token from a capability system]

> (this 'fingerprint' mechanizm can be used for any object, not only files.)

One good thing about tokens is that file handles can be implemented on
top of them in user space.

On the other hand, there already are mechanisms to pass file descriptors
around and so on, so you don't gain anything tangible from your efford.

I would advise reading some text books about capability systems, there
is a lot to be learned here.  But retrofitting something like this on an
existing kernel is probably not a very good idea.  Experience shows that
you can't "un-bloat" a piece of software by introducing a few elegant
concepts.  The compatibility stuff eats most of the benefits.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
