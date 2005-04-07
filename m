Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVDGAaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVDGAaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVDGAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 20:30:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13984 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262360AbVDGAaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 20:30:10 -0400
Date: Thu, 7 Apr 2005 02:30:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory options
In-Reply-To: <1112831857.14584.43.camel@localhost>
Message-ID: <Pine.LNX.4.61.0504070219160.15339@scrub.home>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>  <42544D7E.1040907@linux-m68k.org>
 <1112821319.14584.28.camel@localhost>  <Pine.LNX.4.61.0504070133380.25131@scrub.home>
 <1112831857.14584.43.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Apr 2005, Dave Hansen wrote:

> > Why is this choice needed at all? Why would one choose SPARSEMEM over 
> > DISCONTIGMEM?
> 
> For now, it's only so people can test either one, and we don't have to
> try to toss DICONTIGMEM out of the kernel in fell swoop.  When the
> memory hotplug options are enabled, the DISCONTIG option goes away, and
> SPARSEMEM is selected as the only option.
> 
> I hope to, in the future, make the options more like this:
> 
> config MEMORY_HOTPLUG...
> config NUMA...
> 
> config DISCONTIGMEM
> 	depends on NUMA && !MEMORY_HOTPLUG
> 
> config SPARSEMEM
> 	depends on MEMORY_HOTPLUG || OTHER_ARCH_THING
> 
> config FLATMEM
> 	depends on !DISCONTIGMEM && !SPARSEMEM

I was hoping for this too, in the meantime can't you simply make it a 
suboption of DISCONTIGMEM? So an extra option is only visible when it's 
enabled and most people can ignore it completely by just disabling a 
single option.

> > Help texts such as "If unsure, choose <something else>" make 
> > the complete config option pretty useless.
> 
> They don't make it useless, they just guide a clueless user to the right
> place, without them having to think about it at all.  Those of us that
> need to test the various configurations are quite sure of what we're
> doing, and can ignore the messages. :)
> 
> I'm not opposed to creating some better help text for those things, I'm
> just not sure that we really need it, or that it will help end users get
> to the right place.  I guess more explanation never hurt anyone.

Some basic explanation with a link for more information can't hurt.

bye, Roman
