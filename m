Return-Path: <linux-kernel-owner+w=401wt.eu-S1750946AbXAICqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbXAICqe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXAICqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:46:34 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:56404 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXAICqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:46:34 -0500
Date: Mon, 8 Jan 2007 18:45:14 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] Remove useless FIND_FIRST_BIT() macro from cardbus.c.
Message-Id: <20070108184514.6034ccb5.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0701082015270.3951@localhost.localdomain>
References: <Pine.LNX.4.64.0701082015270.3951@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 20:20:28 -0500 (EST) Robert P. J. Day wrote:

> 
>   Delete the definition of the unused FIND_FIRST_BIT() macro.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   this macro seems safely deletable, given that there is no other
> reference to that macro anywhere in the entire source tree and,
> besides, one should use find_first_bit() anyway.
> 
>   it's not clear who the official maintainer is for this subsystem
> these days.

I believe that it should go to (from MAINTAINERS):

PCMCIA SUBSYSTEM
P:	Linux PCMCIA Team
L:	linux-pcmcia@lists.infradead.org
L:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
T:	git kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
S:	Maintained

> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 2d7effe..a1bd763 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -40,8 +40,6 @@
> 
>  /*====================================================================*/
> 
> -#define FIND_FIRST_BIT(n)	((n) - ((n) & ((n)-1)))
> -
>  /* Offsets in the Expansion ROM Image Header */
>  #define ROM_SIGNATURE		0x0000	/* 2 bytes */
>  #define ROM_DATA_PTR		0x0018	/* 2 bytes */
> -

---
~Randy
