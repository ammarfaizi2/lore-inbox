Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRDSPWc>; Thu, 19 Apr 2001 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRDSPWW>; Thu, 19 Apr 2001 11:22:22 -0400
Received: from 4dyn165.delft.casema.net ([195.96.105.165]:8465 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129242AbRDSPWP>; Thu, 19 Apr 2001 11:22:15 -0400
Message-Id: <200104191522.RAA08182@cave.bitwizard.nl>
Subject: Re: [kbuild-devel] Re: Cross-referencing frenzy
In-Reply-To: <20010419093613.A32121@thyrsus.com> from "Eric S. Raymond" at "Apr
 19, 2001 09:36:13 am"
To: "Eric S. Raymond" <esr@thyrsus.com>
Date: Thu, 19 Apr 2001 17:22:01 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        "Edward S. Marshall" <esm@logic.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> Rogier Wolff <R.E.Wolff@BitWizard.nl>:
> > I think it should be possible to do: 
> > 
> > /* to enable the special stuff, change the "undef" to "define",
> >    If you really want you can add this to Config.in so that you're presented
> >    with this choice when configuring your kernel. But it's not neccesary
> >    for the general public to always see this toggle.  */
> > #undef CONFIG_SX_SPECIALSTUFF
> > 
> > #ifdef CONFIG_SX_SPECIALSTUFF
> > ...
> > 
> > #endif
> 
> Yes, I could write and test code to handle this in about twenty minutes.
> And I was about to do it when I realized that it would be the wrong thing.
> 
> The right answer is that CONFIG_SX_SPECIALSTUFF *should* be flagged as
> an error -- because it doesn't belong in the CONFIG_ namespace, which
> by definition should be reserved for things the configurators control.
> 
> It should be called something else: perhaps ENABLE_SX_SPECIALSTUFF

You surely can do 

#undef ENABLE_SX_SPECIALSTUFF

however, then the "upgrade path" to a configurable parameter in the
configuration stuff is harder.

Now, as far as I know, this is rarely (if ever) used right now. (but
I've been tempted to do it in the past) Maybe with better
configuration tools, always declaring it a configuration option is a
good idea.

Think about it. Consider the issue, decide whatever you want. Tell me
about it. (i.e. what you suggest is the best way to deal with this.) (*)



			Roger. 

(*) you may say: "But I just did that". However the above hints at
that you skipped over the "but I'd like to prepare for the case where
the configuration of that parameter should be made easier by including
it in the config mechanism."

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
