Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVKBObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVKBObV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVKBObV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:31:21 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9720 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965026AbVKBObV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:31:21 -0500
Date: Wed, 2 Nov 2005 07:31:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-ID: <20051102143120.GC3839@smtp.west.cox.net>
References: <2.494767362@selenic.com> <20051102170053.1c120a03.akpm@osdl.org> <20051102070337.GC4367@waste.org> <20051102174020.37da0396.akpm@osdl.org> <17256.33817.263105.197325@cargo.ozlabs.ibm.com> <20051102130435.GA24230@suse.de> <20051102141407.GB3839@smtp.west.cox.net> <20051102141954.GA29679@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102141954.GA29679@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 03:19:54PM +0100, Olaf Hering wrote:
>  On Wed, Nov 02, Tom Rini wrote:
> 
> > I've always thought one of the nice points about ppc linux was that the
> > kernel just booted on your board, no matter what crazy firmware there
> > was.
> 
> I cant speak for anything else than CONFIG_PPC_MULTIPLATFORM, but I bet
> almost noone really uses the boot wrapper from the kernel. An external
> mkzimage for the rest of the supported boards sounds like a good plan.
> Cant be that hard to maintain as the kernel interface is stable.
> We have such thing in opensuse, it needs an update for PReP and iSeries
> to provide the flat device tree.

That's true, but PPC_MULTIPLATFORM (in old speak) was also the boring
case.  The problem with ripping it out is there's always a reliance on
things the kernel knows anyhow (serial is here, something else we need
to kick is there, and so on).  Not that it couldn't be duplicated
elsewhere, but it would be duplication.

-- 
Tom Rini
http://gate.crashing.org/~trini/
