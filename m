Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWCMH54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWCMH54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWCMH54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:57:56 -0500
Received: from mail.terralink.de ([217.9.16.16]:49344 "EHLO mail.terralink.de")
	by vger.kernel.org with ESMTP id S932331AbWCMH5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:57:55 -0500
Date: Mon, 13 Mar 2006 08:57:42 +0100
From: Johannes Goecke <goecke@upb.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
Message-ID: <20060313075741.GA31459@uni-paderborn.de>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20060311192840.GA19313@uni-paderborn.de> <1142134890.25358.43.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142134890.25358.43.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040907i
X-added-header: added by server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 10:41:29PM -0500, Lee Revell wrote:
> On Sat, 2006-03-11 at 20:28 +0100, Johannes Goecke wrote:
> > - how to enshure that the code is executed ONLY on excactly this kind
> > of boards
> >  (not any other with similar Chipset)?
> > 
> > - what to do to (hopefully) integrate that pice of code into
> >   one of the next Kernel Releases?
> > 
> 
> This has been discussed on LKML recently, it's not 2.6.16 material
> because it might break working setups when the previously disabled
> device becomes the default sound card.  Of course the same setup would
> have broken if we added a driver for a previously unsupported soundcard,
> so I'm not sure how this fits in with the "don't break userspace" rule.


would it be useful to add a compile-time-option and additionally
a kernel-command-line option for some bogus-code like

if ( commandline-enable || compiletime-enable ) 
{
	/* Enable all Soundcards- Found */
}

?

- no default behaviour is changed
- general purpose Kernels can have Quirks integrated if needed

> 
> IMHO it should be merged post 2.6.16.
> 
> Lee
> 

Johannes Goecke

PS:
can someone give me a (kernel-programming-beginner-level) hint, for the first 
question how to ensure to only execute if running on the right Mother-board?
Af far as I believe the quirk so-far only checks the cipset, so it might
behave wrong on other Mainborads! 
