Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUDVRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUDVRjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUDVRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:39:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:28591 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264611AbUDVRji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:39:38 -0400
Message-Id: <200404221738.i3MHcg7J005234@eeyore.valparaiso.cl>
To: alex@pilosoft.com
Cc: jamal <hadi@cyberus.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: tcp vulnerability? haven't seen anything on it here... 
In-Reply-To: Your message of "Thu, 22 Apr 2004 11:27:05 -0400."
             <Pine.LNX.4.44.0404221121230.2738-100000@paix.pilosoft.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 22 Apr 2004 13:38:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex@pilosoft.com said:
> > > > Unless i misunderstood: You need someone/thing to see about 64K
> > > > packets within a single flow to make the predicition so the attack
> > > > is succesful. Sure to have access to such capability is to be in a
> > > > hostile path, no? ;->
> > > No, you do not need to see any packet.

> > Ok, so i misunderstood then. How do you predict the sequences without
> > seeing any packet? Is there any URL to mentioned paper?

> You don't - just brute-force the tcp 4-tuple and sequence number. The
> attack relies on the fact that you don't have to match sequence number
> exactly, which cuts down on the search-space. (If total search space is
> 2^32, rwin is 16k, effective attack search space is 2^32/16k). Multiplied 
> by number of ephemeral ports, it becomes *feasible* but still not very 
> likely.

If everybody (or at least the bigger knots) filters spoofed traffic, this
ceases to be a problem. And that solves a shipload of other problems, so...

If the cracker has access to the connection between routers (quite unlikely
for BGP), there is other, lower-hanging, fun to be had... and in that case
they can just read the exact data from the stream, no guessing needed at
all. And no protection possible either AFAICS.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
