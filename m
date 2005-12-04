Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLDQGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLDQGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVLDQGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:06:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41231 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932082AbVLDQGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:06:50 -0500
Date: Sun, 4 Dec 2005 16:59:11 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Final 2.4.x SATA updates
Message-ID: <20051204155911.GA5924@alpha.home.local>
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org> <438FA62D.2040707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438FA62D.2040707@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Thu, Dec 01, 2005 at 08:41:01PM -0500, Jeff Garzik wrote:
> Erik Andersen wrote:
> >On Thu Dec 01, 2005 at 04:48:37PM -0500, Jeff Garzik wrote:
> >
> >>Now that ATAPI support is pretty stable, the 2.4 version of libata will
> >>be receiving its final updates soon.  Here is the current backport,
> >>for testing and feedback.
> >
> >
> >Awesome.  2.4.x lacks KM_IRQ0 in kmap_types.h
> >
> >gcc -D__KERNEL__ -I/usr/src/linux-2.4.32/include -Wall 
> >-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
> >-fomit-frame-pointer -Os -falign-functions=2 -falign-jumps=2 
> >-falign-labels=2 -falign-loops=2 -pipe -mpreferred-stack-boundary=2 
> >-march=i486  -DMODULE  -nostdinc -iwithprefix include 
> >-DKBUILD_BASENAME=libata_core  -DEXPORT_SYMTAB -c libata-core.c
> >libata-core.c: In function `ata_sg_clean':
> >libata-core.c:2427: error: `KM_IRQ0' undeclared (first use in this 
> >function)
> >libata-core.c:2427: error: (Each undeclared identifier is reported only 
> >once
> >libata-core.c:2427: error: for each function it appears in.)
> >libata-core.c: In function `ata_sg_setup':
> >libata-core.c:2701: error: `KM_IRQ0' undeclared (first use in this 
> >function)
> >make[2]: *** [libata-core.o] Error 1
> 
> hmmm, interesting.  Easy enough to fix.  I guess I didn't build on a 
> highmem box.

Same problem for me, but unfortunately, I don't know how to fix this. I've
seen that KM_IRQ* are not defined on x86. I don't know if I can use other
ones, not what would be the consequences. Would you please enlighten me a
bit on this, I'm willing to test it but don't know how to build it first.

Thanks in advance,
Willy

