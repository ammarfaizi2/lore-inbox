Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUJ3Lsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUJ3Lsp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbUJ3Lsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:48:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:48369 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263709AbUJ3Lsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:48:38 -0400
Date: Sat, 30 Oct 2004 13:48:34 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
cc: <isdn4linux@listserv.isdn4linux.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       <developers@melware.de>
Subject: Re: RFC: [2.6 patch] Eicon: disable debuglib for modules
In-Reply-To: <20041030072256.GH4374@stusta.de>
Message-ID: <Pine.LNX.4.31.0410301343450.24225-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Adrian Bunk wrote:
> Is there a good reason why debuglib is enabled for modules?

Yes.
Without it, there would be no possibility to use the maintainance module
to debug the isdn/card/capi interaction.

> If not, I'd propose the patch below to disable it.

I have to disagree. This patch would disable a major feature of the
diva driver collection.

Armin

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/eicon/platform.h.old	2004-10-30 08:39:51.000000000 +0200
> +++ linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/eicon/platform.h	2004-10-30 08:40:28.000000000 +0200
> @@ -35,10 +35,8 @@
>
>  #include "cardtype.h"
>
> -/* activate debuglib for modules only */
> -#ifndef MODULE
> +/* disable debuglib */
>  #define DIVA_NO_DEBUGLIB
> -#endif
>
>  #define DIVA_INIT_FUNCTION  __init
>  #define DIVA_EXIT_FUNCTION  __exit
>

