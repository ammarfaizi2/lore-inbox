Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTIAQf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTIAQf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:35:56 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:61127 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263069AbTIAQfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:35:07 -0400
Date: Mon, 1 Sep 2003 09:35:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: marcel@holtmann.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Firmware loading depends on hotplug support
Message-ID: <20030901163505.GA27754@ip68-0-152-218.tc.ph.cox.net>
References: <200309011502.h81F2Mq6003467@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011502.h81F2Mq6003467@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 04:27:11PM +0000, marcel@holtmann.org wrote:
> ChangeSet 1.1065.2.3, 2003/08/15 18:27:11+02:00, marcel@holtmann.org
> 
> 	[PATCH] Firmware loading depends on hotplug support
> 	
> 	This patch makes the firmware loading support only selectable if the
> 	hotplug support is also enabled.
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1065.2.2 -> 1.1065.2.3
> #	       lib/Config.in	1.4     -> 1.5    
> #
> 
>  Config.in |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff -Nru a/lib/Config.in b/lib/Config.in
> --- a/lib/Config.in	Mon Sep  1 08:02:24 2003
> +++ b/lib/Config.in	Mon Sep  1 08:02:24 2003
> @@ -41,7 +41,8 @@
>    fi
>  fi
>  
> -if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
> +if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
> +     "$CONFIG_HOTPLUG" = "y" ]; then
>     tristate 'Hotplug firmware loading support (EXPERIMENTAL)' CONFIG_FW_LOADER
>  fi

Is this really a good idea, given that USB devices may be hot-plugged,
without CONFIG_HOTPLUG set (drivers are compiled in, for example) ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
