Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUCOQDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUCOQDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:03:17 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:28340 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262623AbUCOQDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:03:14 -0500
Date: Mon, 15 Mar 2004 09:03:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-bk3 ppc32 compile fix
Message-ID: <20040315160313.GB4342@smtp.west.cox.net>
References: <20040314225913.4654347b@jack.colino.net> <20040315155120.GA4342@smtp.west.cox.net> <035701c40aa5$1549b490$3cc8a8c0@epro.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035701c40aa5$1549b490$3cc8a8c0@epro.dom>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 04:49:21PM +0100, Colin Leroy wrote:

> > > 2.6.4-bk3 (ie, 2.6.4 + bk3 patch at kernel.org) does not compile
> without this patch.
> >
> > How does it fail to compile?
> 
> Same problem as here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107935807420183&w=2
> 
> include/asm/unistd.h:451: syntax error before "long"
> 
> (maybe adding the #include <linux/linkage.h> to init/do_mounts_initrd.c is
> better than where I did put it).

The problem is that on PPC32 (and probably sparc64) 'asmlinkage' is a
useless keyword, and should just be removed from
include/asm-ppc/unistd.h.

-- 
Tom Rini
http://gate.crashing.org/~trini/
