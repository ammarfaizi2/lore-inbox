Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWJTSEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWJTSEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWJTSEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:04:12 -0400
Received: from solarneutrino.net ([66.199.224.43]:28687 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S2992554AbWJTSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:04:11 -0400
Date: Fri, 20 Oct 2006 14:03:54 -0400
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
Message-ID: <20061020180354.GB29810@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net> <1160849723.3943.41.camel@neko.keithp.com> <20061017174020.GA24789@tau.solarneutrino.net> <1161124062.25439.8.camel@neko.keithp.com> <4535CFB1.2010403@tungstengraphics.com> <20061019173108.GA28700@tau.solarneutrino.net> <4538B670.2030105@tungstengraphics.com> <20061020164008.GA29810@tau.solarneutrino.net> <45390C85.3070604@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45390C85.3070604@tungstengraphics.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 06:51:01PM +0100, Keith Whitwell wrote:
> Ryan Richter wrote:
> >On Fri, Oct 20, 2006 at 12:43:44PM +0100, Keith Whitwell wrote:
> >>Ryan Richter wrote:
> >>>On Wed, Oct 18, 2006 at 07:54:41AM +0100, Keith Whitwell wrote:
> >>All of your other wierd problems, like the assert failures, etc, make me 
> >>wonder if there just hasn't been some sort of build problem that can 
> >>only be resolved by clearing it out and restarting.
> >>
> >>It wouldn't hurt to just nuke your current Mesa and libdrm builds and 
> >>start from scratch - you'll probably have to do that to get debug 
> >>symbols for gdb anyway.
> >
> >I had heard something previously about i965_dri.so maybe getting
> >miscompiled, but I hadn't followed up on it until now.  I rebuilt it
> >with an older gcc, and now it's all working great!  Sorry for the wild
> >goose chase.
> 
> Out of interest, can you try again with the original GCC and see if the 
> problem comes back?  Which versions of GCC are you using?

The two gcc versions are the 4.1 (miscompiles) and 3.4 (OK) from Debian
unstable.  I had originally compiled it myself with gcc-4.1 because the
Debian libgl1-mesa-dri package didn't build i965_dri.so until I
submitted a build patch to them to have it built.  They released a new
package a few days ago with i965_dri.so included, presumably built with
the same gcc-4.1, the default cc on Debian unstable.

I had exactly the same problems with my own version and theirs.  I
rebuilt it again today with CC=gcc-3.4 and now everything works great.
I saved a copy of the old i965_dri.so, so I can verify in the next few
days that replacing it breaks things again.  Let me know if you want
copies of these files to examine.

-ryan
