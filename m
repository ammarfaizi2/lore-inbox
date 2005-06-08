Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVFHVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVFHVrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVFHVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:47:48 -0400
Received: from mailfe10.swip.net ([212.247.155.33]:36578 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262025AbVFHVrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:47:06 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] capabilities not inherited
From: Alexander Nyberg <alexn@telia.com>
To: Manfred Georg <mgeorg@arl.wustl.edu>
Cc: Chris Wright <chrisw@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506081627170.11409@polyester.arl.wustl.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
	 <20050608204430.GC9153@shell0.pdx.osdl.net>
	 <1118265642.969.12.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0506081627170.11409@polyester.arl.wustl.edu>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 23:46:57 +0200
Message-Id: <1118267217.969.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-06-08 klockan 16:33 -0500 skrev Manfred Georg:
> On Wed, 8 Jun 2005, Alexander Nyberg wrote:
> > btw since the last discussion was about not changing the existing
> > interface and thus exposing security flaws, what about introducing
> > another prctrl that says maybe PRCTRL_ACROSS_EXECVE?
> 
> Wasn't the original inherited set supposed take care of that?

Yes

> > Any new user-space applications must understand the implications of
> > using it so it's safe in that aspect. Yes?
> 
> As far as I can tell, applying the patch from the earlier discussion
> and setting the inherited set has the same, "I really meant to do this"
> effect as what you propose.

But since it didn't do what it was supposed to from the beginning some
people don't want to change it because it might open up security holes
and I can understand that. So maybe we need some new flag for
applications to say "I really want to do this" and noone can say we
break old interfaces (mess upon mess...)

> > (yeah it's rather silly since there already is an unused
> > keep_capabilities flag but that would change old interfaces so ok)
> 
> Isn't the keep_capabilities flag related to setuid() ? or did I miss
> something.
> 

Yeah it's related to changing user IDs, it's me who is lost, sorry.

And I still think having apps being able to keep a chain of capabilities
would be very useful, most noticeable pam_cap so that normal users can
have capabilities like chroot, running SCHED_FIFO or SCHED_RR, mlock
etc. But let's see what Chris has to say about another flag for explicit
inheritance.

