Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWC3BhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWC3BhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWC3BhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:37:03 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45785
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751420AbWC3BhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:37:00 -0500
From: Rob Landley <rob@landley.net>
To: Nix <nix@esperi.org.uk>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Wed, 29 Mar 2006 20:36:38 -0500
User-Agent: KMail/1.8.3
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Eric Piel <Eric.Piel@tremplin-utc.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603281647.06020.rob@landley.net> <87irpxvtb3.fsf@hades.wkstn.nix>
In-Reply-To: <87irpxvtb3.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603292036.38937.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 March 2006 4:23 pm, Nix wrote:
> On Tue, 28 Mar 2006, Rob Landley announced authoritatively:
> > I play with Fabrice Bellard's Tiny C Compiler (http://www.tinycc.org),
> > and hope to get a distro compiled with it someday, at least as a proof of
> > concept.
>
> It's a nifty idea, a sort of uClibc of C compilers. Alas it's useless on
> almost all my systems because it's x86-only by design...

Actually according to the changelog version 0.9.21 grew support for ARM, and I 
believe it supports some other platforms too.

Notice that Fabrice Bellard (who wrote it) is also the guy behind qemu.  My 
vague understanding of how things went is that at some point after doing 
tccboot, he was decoupled the C parser from the code generator in order to 
retarget tcc to produce code for other platforms, and got the idea of 
producing different front-ends too so it could input something other than C, 
namely machine code.

The result was qemu, which sort of compiles machine code to machine code 
dynamically, and which has taken up a large chunk of his time ever since.  
(The speed of tcc development has tailed off noticeably since, but he still 
spends a little time on it, and there are other developers...)

> > That aims for full c99 and is already implementing a lot of gcc stuff
> > too.
>
> Good for it, as long as it doesn't go on to define __GNUC__ like icc did
> at one point (even though it doesn't implement all GCC
> extensions)... but Fabrice is sane so I doubt he'd do anything that
> loopy.

That's more a header issue anyway.  That's the uClibc developers problem. :)

Rob
-- 
Never bet against the cheap plastic solution.
