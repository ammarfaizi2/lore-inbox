Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTFYUJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTFYUJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:09:06 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:1417 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id S265026AbTFYUH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:07:59 -0400
Date: Wed, 25 Jun 2003 22:22:09 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix in-kernel genksyms for parisc symbols 
In-Reply-To: <20030625061924.3D1272C28B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306252221320.10554-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Rusty Russell wrote:

> In message <1056410864.1826.57.camel@mulgrave> you write:
> > The problem is that the parisc libgcc.a library contains symbols that
> > look like $$mulI and the like, but genksyms doesn't think $ is legal for
> > a function symbol, so they all get dropped from the output.  This means
> > that inserting almost any module on parisc taints the kernel because
> > these symbols have no version.
> > 
> > The fix (attached below) was to allow $ in an identifier in lex.l (and
> > obviously to update the _shipped files as well, but my flex/bison seem
> > to be rather different from the one they were generated with, so I'll
> > leave that to whomever has the correct versions).
> 
> Looks fine, but my flex is different, too.  Kai?

I merged it, will submit.

--Kai

