Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVGVEzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVGVEzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGVEzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:55:13 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:10956 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261933AbVGVEzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:55:11 -0400
Date: Fri, 22 Jul 2005 00:53:58 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-Reply-To: <E1Dvp8T-0007wp-00@w-gerrit.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0507220033371.4935-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.21.45
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > yes, that's the crux.  CKRM is all about resolving conflicting resource 
> > > demands in a multi-user, multi-server, multi-purpose machine.  this is a 
> > > huge undertaking, and I'd argue that it's completely inappropriate for 
> > > *most* servers.  that is, computers are generally so damn cheap that 
> > > the clear trend is towards dedicating a machine to a specific purpose, 
> > > rather than running eg, shell/MUA/MTA/FS/DB/etc all on a single machine.  
>  
> This is a big NAK - if computers are so damn cheap, why is virtualization
> and consolidation such a big deal?  Well, the answer is actually that

yes, you did miss my point.  I'm actually arguing that it's bad design
to attempt to arbitrate within a single shared user-space.  you make 
the fast path slower and less maintainable.  if you are really concerned
about isolating many competing servers on a single piece of hardware, then
run separate virtualized environments, each with its own user-space.

