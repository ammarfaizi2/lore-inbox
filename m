Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVDFXlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVDFXlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVDFXlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:41:03 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3744 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262346AbVDFXk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:40:57 -0400
Date: Thu, 7 Apr 2005 01:40:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory options
In-Reply-To: <1112821319.14584.28.camel@localhost>
Message-ID: <Pine.LNX.4.61.0504070133380.25131@scrub.home>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>  <42544D7E.1040907@linux-m68k.org>
 <1112821319.14584.28.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Apr 2005, Dave Hansen wrote:

> On Wed, 2005-04-06 at 22:58 +0200, Roman Zippel wrote:
> > Dave Hansen wrote:
> > > --- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-04-04 09:04:48.000000000 -0700
> > > +++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:23.000000000 -0700
> > > @@ -0,0 +1,25 @@
> > > +choice
> > > +	prompt "Memory model"
> > > +	default FLATMEM
> > > +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> > > +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
> > 
> > Does this really have to be a user visible option and can't it be
> > derived from other values? The help text entries are really no help at all.
> 
> I hope that this selection will replace the current DISCONTIGMEM prompts
> in the individual architectures.  That way, you won't get a net increase
> in the number of prompts.

Why is this choice needed at all? Why would one choose SPARSEMEM over 
DISCONTIGMEM? Help texts such as "If unsure, choose <something else>" make 
the complete config option pretty useless.

bye, Roman
