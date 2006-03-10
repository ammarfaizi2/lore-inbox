Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751990AbWCJS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWCJS4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWCJS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:56:17 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:56491
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751990AbWCJS4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:56:16 -0500
Date: Fri, 10 Mar 2006 12:55:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060310185555.GI7110@waste.org>
References: <0.399206195@selenic.com> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <dul4qd$100$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dul4qd$100$1@terminus.zytor.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 03:26:05PM -0800, H. Peter Anvin wrote:
> Followup to:  <20060225212247.GC15276@flint.arm.linux.org.uk>
> By author:    Russell King <rmk+lkml@arm.linux.org.uk>
> In newsgroup: linux.dev.kernel
> > 
> > All these are to do with decompressing a compressed kernel.  If they
> > fail, halting is perfectly reasonable because we probably don't have
> > an executable kernel.  Your arguments are fine for these.  But, that's
> > not the full story - there are two more places where this code is
> > used:
> > 
> > init/do_mounts_rd.c:#include "../lib/inflate.c"
> > init/initramfs.c:#include "../lib/inflate.c"
> > 
> > for these your arguments that halting is fine is _NOT_ correct nor is it
> > desirable.  The first of these is the cause of the problems both myself
> > and others saw, as detailed in the URL I posted previously in this thread.
> > Did you read that post?
> > 
> 
> These probably should use lib/zlib instead...

That's a reasonable suggestion. I have an eventual goal of getting
down to only one (cleaned up) zlib instance in the kernel and I'm
somewhat more appalled by the lib/zlib/inflate code so I haven't gone
that route.

-- 
Mathematics is the supreme nostalgia of our time.
