Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423694AbWJaRWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423694AbWJaRWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423699AbWJaRWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:22:51 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:61327 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1423694AbWJaRWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:22:50 -0500
Date: Tue, 31 Oct 2006 14:22:38 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061031172237.GD5319@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061030203334.09caa368.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 18:33:19 -0300
> Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> 
> > 	I've been working on some DWARF2 utilities and thought that it
> > is about time I announce it to the community, so that what is already
> > available can be used by people interested in reducing structure sizes
> > and otherwise taking advantage of the information available in the elf
> > sections of files compiled with 'gcc -g' or in the case of the kernel
> > with CONFIG_DEBUG_INFO enabled, so here it goes the description of said
> > tools:
> > 
> > pahole: Poke-a-Hole is a tool to find out holes in structures, holes
> > being defined as the space between members of functions due to alignemnt
> > rules that could be used for new struct entries or to reorganize
> > existing structures to reduce its size, without more ado lets see what
> > that means:
> > 
> > ...
> >
> > 	Further ideas on how to use the DWARF2 information include tools
> > that will show where inlines are being used, how much code is added by
> > inline functions,
> 
> It would be quite useful to be able to identify inlined functions which are
> good candidates for uninlining.

I'm working on making good use of this information:

--------------- 8< --------------

3.3.8.2 Concrete Inlined Instances

Each inline expansion of an inlinable subroutine is represented by a
debugging information entry with the tag DW_TAG_inlined_subroutine.
Each such entry should be a direct child of the entry that represents
the scope with in which the inlining occurs.

--------------- 8< --------------

To write this tool:

<Ralf> So imagine a tool which says function x was inlined y times
bloating the code by z bytes :)

:-)

- Arnaldo
