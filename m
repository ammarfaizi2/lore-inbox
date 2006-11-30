Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936303AbWK3Mcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936303AbWK3Mcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936324AbWK3Mcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:32:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:8934 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S936303AbWK3Mc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:32:28 -0500
Date: Thu, 30 Nov 2006 13:32:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <bcollins@ubuntu.com>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 4/4] [HVCS] Select HVC_CONSOLE if HVCS is enabled.
In-Reply-To: <1164860773166-git-send-email-bcollins@ubuntu.com>
Message-ID: <Pine.LNX.4.64.0611301331520.6243@scrub.home>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
 <1164860773166-git-send-email-bcollins@ubuntu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Ben Collins wrote:

> If HVC_CONSOLE provides symbols that HVCS requires.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> ---
>  drivers/char/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 2af12fc..c94ecdc 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -598,6 +598,7 @@ config HVC_RTAS
>  config HVCS
>  	tristate "IBM Hypervisor Virtual Console Server support"
>  	depends on PPC_PSERIES
> +	select HVC_CONSOLE
>  	help
>  	  Partitionable IBM Power5 ppc64 machines allow hosting of
>  	  firmware virtual consoles from one Linux partition by


Why not a normal dependency?

bye, Roman
