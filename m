Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVAaB5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVAaB5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVAaB5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:57:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:28603 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261889AbVAaB5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:57:12 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Date: Mon, 31 Jan 2005 02:57:10 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org>
In-Reply-To: <20050130193733.GA8984@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501310257.10962.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 20:37, Sam Ravnborg wrote:
> We have in several cases the need to transpose a i'm' to 'y' in the Kbuild
> files.

I assume you mean what you write in the text rather than what the example 
shows. If so, why not use this:

obj-$(CONFIG_SND:m=y) += last.o

> One example is the following snippet from sound/Makefile:
> ifeq ($(CONFIG_SND),y)
>   obj-y += last.o
> endif
>
> [...]
>
> To be complete the full set would be:
>
> ym2y
> ym2m
> empty2y
> empty2m
> y2y
> m2y
> y2m
> m2m
> yx2x
> mx2x
>
>
> Would that be considered usefull?

That would take the kbuild makefile obfuscation contest to the next level. Who 
should understand that stuff?

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
