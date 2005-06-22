Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFVOsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFVOsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFVOrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:47:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13491 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261346AbVFVOop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:44:45 -0400
Date: Wed, 22 Jun 2005 16:44:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Fix signed char problem in scripts/kconfig
In-Reply-To: <42B92946.3010207@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0506221642240.3728@scrub.home>
References: <42B92946.3010207@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Jun 2005, Pierre Ossman wrote:

> The signed characters in scripts are causing warnings with GCC 4 on
> systems with proper string functions (with char*, not signed char* as
> parameters). Some could be kept signed but most had to be reverted to
> normal chars.
> 
> Detailed changelog:
> 
> mconf.c:
> 	- buf/bufptr was used in vsprintf() so it couldn't be signed.
> confdata.c:
> 	- conf_expand_value() used strchr() and strncat() forcing
> 	  "normal" strings.
> conf.c:
> 	- line was used with several string functions so it couldn't be
> 	  signed.
> 	- strip() uses strlen() so same thing there.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Acked-by: Roman Zippel <zippel@linux-m68k.org>

Looks good, thanks.

bye, Roman
