Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265644AbUFIOh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUFIOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUFIOhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:37:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:36309 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265644AbUFIOhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:37:52 -0400
Date: Wed, 9 Jun 2004 16:37:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
In-Reply-To: <20040609023308.GC24042@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.56.0406091632550.26677@jjulnx.backbone.dif.dk>
References: <20040609023308.GC24042@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, Andreas Dilger wrote:

> On Jun 09, 2004  03:38 +0200, Jesper Juhl wrote:
> > drivers/ide/ide.c: In function `ide_unregister_subdriver':
> > drivers/ide/ide.c:2216: warning: implicit declaration of function
> `pnpide_init'
> >
> > I added a simple declaration of pnpide_init to drivers/ide/ide.c
> >
> > Here's a patch against 2.6.7-rc3 - please consider including it (or if
> > that's not the way to do it, then don't) :)
> Better to add the declaration into a header like linux/ide.h that is
> included into both ide.c and ide-pnp.c so that when/if pnpide_init()
> ever changes its prototype you will get a warning during compilation.
> The only good reason to have declarations within .c files is for forward
> declarations of functions only used in the same file.

That makes perfect sense. I actually considered making a header for it,
but since it would contain only a single declaration I abandoned that - I
see now that I should have done that in any case to avoid stuff becomming
out of sync.

Would you like an updated patch ?


--
Jesper Juhl <juhl@dif.dk>

