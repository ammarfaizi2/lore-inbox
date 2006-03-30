Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWC3U0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWC3U0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWC3U0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:26:44 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3806 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750822AbWC3U0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:26:44 -0500
From: Rob Landley <rob@landley.net>
To: Nix <nix@esperi.org.uk>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Thu, 30 Mar 2006 15:26:14 -0500
User-Agent: KMail/1.8.3
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603292036.38937.rob@landley.net> <87k6actmy2.fsf@hades.wkstn.nix>
In-Reply-To: <87k6actmy2.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301526.14744.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 2:24 am, Nix wrote:
> On Wed, 29 Mar 2006, Rob Landley whispered secretively:
> > Actually according to the changelog version 0.9.21 grew support for ARM,
> > and I believe it supports some other platforms too.
>
> That's... impressive. Of course the more generality it grows the slower
> it must necessarily become,

Not if compliation speed is the primary explicit design goal from day one, and 
they regression test with that in mind.

Keep in mind that the main use of tcc these days is to turn c into a scripting 
language.  Just start your C file with

#!/usr/bin/tcc -run

And notice that #! is a preprocessor comment line as far as tcc is 
concerned. :)

> > The result was qemu, which sort of compiles machine code to machine code
> > dynamically, and which has taken up a large chunk of his time ever since.
> > (The speed of tcc development has tailed off noticeably since, but he
> > still spends a little time on it, and there are other developers...)
>
> Well, I'd rather he spent time on qemu than tcc; there are other C
> compilers but there's nothing quite like qemu (bochs doesn't work very
> well, valgrind is similar in essence but very different in operation...)

They're still sort of related.  The sad part is that tcc is -><- this close to 
building an unmodified linux kernel, as tccboot demonstrates.  But Fabrice 
seems to have gone "ooh, shiny!" off in another direction, for entirely 
understandable reasons... :)

I'm sure somebody will go take a whack at it sooner or later.  (I haven't got 
time either.)

Rob
-- 
Never bet against the cheap plastic solution.
