Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUBRUYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUBRUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:24:14 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:50392 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S268001AbUBRUYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:24:11 -0500
Date: Wed, 18 Feb 2004 13:23:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-ID: <20040218202357.GU16881@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net> <20040218193624.GA408@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218193624.GA408@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 08:36:24PM +0100, Pavel Machek wrote:

> Hi!
> 
> > The following is the core bits to this KGDB stub.
> 
> What are those weak functions good for? Can't we simply assume that
> any architecture that allows CONFIG_KGDB provides neccessary
> functions?

Not all arches need all functions, and that's where the weak functions
come in.  We could remove some of them (the *gdb*regs* type ones) as
being absolutely required, but not everyone needs kgdb_arch_init.
Similarly for kgdb_flush_io.

> PS: Also.. how to proceed? Should I split your patches into "normal"
> and "lite" parts and submit to Amit?

Tomorrow I leave for FOSDEM, and won't have time to pick on KGDB until I
get back Tuesday.  What I'm going to do then, if no one beats me to it,
is to merge stuff I've got into Amit's patches (the CVS versions off of
sourceforge), except for netpoll-specific portions of the kgdboe patch.

-- 
Tom Rini
http://gate.crashing.org/~trini/
