Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVALAIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVALAIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVALAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:04:44 -0500
Received: from mail.dif.dk ([193.138.115.101]:13804 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262959AbVAKXji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:39:38 -0500
Date: Wed, 12 Jan 2005 00:42:06 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
In-Reply-To: <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.61.0501120036390.3368@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet>
 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
 <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Barry K. Nathan wrote:

> On Sat, Jan 08, 2005 at 10:46:19AM -0800, Linus Torvalds wrote:
> > Another issue is likely that we should make the whole "uselib()"
> > interfaces configurable. I don't think modern binaries use it (where
> > "modern" probably means "compiled within the last 8 years" ;).
> 
> Here's an initial stab at such a patch. It adds a new config option,
[...]
> +config SYS_USELIB
> +	bool "sys_uselib syscall support (needed for old binaries)"
> +	---help---
> +	  Many old binaries (e.g. dynamically linked a.out binaries, and
> +	  ELF binaries that are dynamically linked against libc5), require
> +	  the sys_uselib syscall. However, on the typical Linux system, this
> +	  code is just old cruft that no longer serves a purpose.
> +
> +	  If you are unsure, say "N" if you care more about security and
> +	  trimming bloat, or say "Y" if you care more about compatibility
> +	  with old software. (If you will answer "Y" or "M" to BINFMT_AOUT,
> +	  below, you probably should answer "Y" here.)
> +

This last bit is not too readable IMO. I'd suggest something like this 
instead : 

       If you care mostly about security and trimming bloat, say "N".
       If you care more about compatibility with old software (or if
       you will answer "Y" or "M" to BINFMT_AOUT below) say "Y".
       
       If unsure, say "Y".



-- 
Jesper Juhl

