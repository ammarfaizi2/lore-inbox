Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWFZLhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWFZLhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWFZLhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:37:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43752 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750752AbWFZLhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:37:20 -0400
Date: Mon, 26 Jun 2006 13:37:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 61/61] lock validator: enable lock validator in Kconfig
In-Reply-To: <20060623110119.GS4889@elte.hu>
Message-ID: <Pine.LNX.4.64.0606261317520.12900@scrub.home>
References: <20060529212812.GI3155@elte.hu> <Pine.LNX.4.64.0605301525510.17704@scrub.home>
 <20060623110119.GS4889@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Jun 2006, Ingo Molnar wrote:

> > Could you please keep all the defaults in a separate -mm-only patch, 
> > so it doesn't get merged?
> 
> yep - the default got removed.

Thanks.

> > > +config LOCKDEP
> > > +	bool
> > > +	default y
> > > +	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
> > 
> > This can be written shorter as:
> > 
> > config LOCKDEP
> > 	def_bool PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
> 
> ok, done. (Btw., there's tons of other Kconfig code though that uses the 
> bool + depends syntax though, and def_bool usage is quite rare.)

The new syntax was added later, so everything that was converted uses the 
basic syntax and is still copied around a lot (where it's probably also 
doesn't help that it's not properly documented yet). I'm still planing to 
go through this and convert most of them...

bye, Roman
