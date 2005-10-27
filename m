Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVJ0RjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVJ0RjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJ0RjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:39:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17129 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751316AbVJ0RjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:39:20 -0400
Message-Id: <200510271737.j9RHbEvf013516@laptop11.inf.utfsm.cl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill massive wireless-related log spam 
In-Reply-To: Message from Jeff Garzik <jgarzik@pobox.com> 
   of "Wed, 26 Oct 2005 11:42:51 EDT." <435FA3FB.9030107@pobox.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 27 Oct 2005 14:37:14 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 27 Oct 2005 14:37:19 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Andi Kleen wrote:
> > On Wednesday 26 October 2005 06:28, Jeff Garzik wrote:
> >
> >>Change this to printing out the message once, per kernel boot.
> > It doesn't do that. It prints it once every 2^32 calls. Also
> 
> ...which is effectively one per kernel boot
> 
> 
> > the ++ causes unnecessary dirty cache lines in normal operation.

> Not a hot path operation by any stretch of the imagination, so that's
fine.

Right. As the "++" is inside "if(!printed) { ... }" it clearly isn't ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

