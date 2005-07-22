Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVGVPxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVGVPxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVGVPxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:53:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31954 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261301AbVGVPxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:53:19 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-reply-to: Your message of Fri, 22 Jul 2005 15:53:55 BST.
             <1122044035.9478.22.camel@localhost.localdomain> 
Date: Fri, 22 Jul 2005 08:51:43 -0700
Message-Id: <E1DvzoN-0007Dg-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005 15:53:55 BST, Alan Cox wrote:
> On Gwe, 2005-07-22 at 00:53 -0400, Mark Hahn wrote:
> > the fast path slower and less maintainable.  if you are really concerned
> > about isolating many competing servers on a single piece of hardware, then
> > run separate virtualized environments, each with its own user-space.
> 
> And the virtualisation layer has to do the same job with less
> information. That to me implies that the virtualisation case is likely
> to be materially less efficient, its just the inefficiency you are
> worried about is hidden in a different pieces of code.
> 
> Secondly a lot of this doesnt matter if CKRM=n compiles to no code
> anyway

I'm actually trying to keep the impact of CKRM=y to near-zero, ergo
only an impact if you create classes.  And even then, the goal is to
keep that impact pretty small as well.

And yes, a hypervisor does have a lot more overhead in many forms.
Something like an overall 2-3% everywhere, where the CKRM impact is
likely to be so small as to be hard to measure in the individual
subsystems, and overall performance impact should be even smaller.
Plus you won't have to manage each operating system instance which
can grow into a pain under virtualization.  But I still maintain that
both have their place.

gerrit
