Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264428AbUEJAlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUEJAlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUEJAlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:41:32 -0400
Received: from waste.org ([209.173.204.2]:45293 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264428AbUEJAla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:41:30 -0400
Date: Sun, 9 May 2004 19:41:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Un-inline spinlocks on ppc64
Message-ID: <20040510004121.GM5414@waste.org>
References: <16542.51381.215308.485006@cargo.ozlabs.ibm.com> <20040509172038.55319fbd.akpm@osdl.org> <Pine.LNX.4.58.0405092025070.1896@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405092025070.1896@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 08:31:44PM -0400, Zwane Mwaikambo wrote:
> yOn Sun, 9 May 2004, Andrew Morton wrote:
> 
> > Paul Mackerras <paulus@samba.org> wrote:
> > >
> > > The patch below moves the ppc64 spinlocks and rwlocks out of line and
> > >  into arch/ppc64/lib/locks.c, and implements _raw_spin_lock_flags for
> > >  ppc64.
> > >
> >
> > It included a hunk against include/asm-ppc64/offsets.h, which I dropped.
> 
> Regarding CONFIG_INLINE_SPINLOCKS, could we call it CONFIG_SPINLINE as is
> the current option supported on i386?

Ugh, I've never liked that config name. Let's change it to be the
less clever version, please.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
