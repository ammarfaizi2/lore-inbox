Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSHHAmH>; Wed, 7 Aug 2002 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSHHAmH>; Wed, 7 Aug 2002 20:42:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:19341 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317112AbSHHAmH>; Wed, 7 Aug 2002 20:42:07 -0400
Date: Wed, 7 Aug 2002 19:45:45 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Matthew Bell <mwsb@operamail.com>
cc: linux-kernel@vger.kernel.org, <becker@scyld.com>
Subject: Re: [PATCH] 2.4.19; 3c515.c <should work with isapnp.o>
In-Reply-To: <20020807234744.9365.qmail@operamail.com>
Message-ID: <Pine.LNX.4.44.0208071943580.19411-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Matthew Bell wrote:

> -#ifdef CONFIG_ISAPNP
> +#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))

You can achieve the same by

+#ifdef __ISAPNP__

assuming you did include <linux/isapnp.h>, which you'd normally do when 
using isapnp ;)

--Kai


