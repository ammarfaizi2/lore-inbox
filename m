Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265907AbUFOUAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUFOUAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUFOUAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:00:47 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:61567 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265907AbUFOUAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:00:03 -0400
Date: Tue, 15 Jun 2004 22:09:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc
Message-ID: <20040615200902.GG2310@mars.ravnborg.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204809.GF15243@mars.ravnborg.org> <200406151213.i5FCDg8M003141@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406151213.i5FCDg8M003141@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:13:39AM -0400, Horst von Brand wrote:
> > +Building external modules
> > +=========================
> > +kbuild offers functionality to build external modules, with the
> > +prerequisite that there is a pre-built kernel avialable with full source.
> 
> No. It should be enough to have run "make modules_prepare".

Correct - it was written some time ago.
I will fix.

> > +A subset of the targets available when building the kernel is available
> > +when building an external module.
> > +
> > +
> > +Building the module
> > +-------------------
> > +The command looks like his:
> > +
> > +	make -C <path to kernel src> M=`pwd`
> 
> For me, it works with:
> 
>   make -C <path to kernel src> SUBDIRS=<path to module source> modules
>      # Builds

Today the modules target is not needed, and SUBDIRS= is equivalent to M=
The M= is more in line with other commandline specifiers, therefore documented.
SUBDIRS= will stay for a long time.


>   make -C <path to kernel src> SUBDIRS=<path to module source> modules_install
>      # Installs
> 
> Besides, IMHO this belongs in Documentation/kbuild/modules.txt.

They will be merged when I'm in documentation mode - if noone beats me.

	Sam
