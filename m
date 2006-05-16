Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWEPQAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWEPQAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWEPQAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:00:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8198 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932108AbWEPQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:00:25 -0400
Date: Tue, 16 May 2006 18:00:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead entry in net wan Kconfig
Message-ID: <20060516160022.GD5677@stusta.de>
References: <1147446494.10079.5.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147446494.10079.5.camel@amdx2.microgate.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 10:08:14AM -0500, Paul Fulghum wrote:

> Remove dead entry from net wan Kconfig.
> This entry is left over from 2.4 where synclink
> used syncppp driver directly. synclink drivers
> now use generic HDLC


What about also removing the entry for this option in the Makefile?


> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> 
> --- linux-2.6.16/drivers/net/wan/Kconfig	2006-03-19 23:53:29.000000000 -0600
> +++ b/drivers/net/wan/Kconfig	2006-05-12 09:17:03.000000000 -0500
> @@ -134,18 +134,6 @@
>  	  The driver will be compiled as a module: the
>  	  module will be called sealevel.
>  
> -config SYNCLINK_SYNCPPP
> -	tristate "SyncLink HDLC/SYNCPPP support"
> -	depends on WAN
> -	help
> -	  Enables HDLC/SYNCPPP support for the SyncLink WAN driver.
> -
> -	  Normally the SyncLink WAN driver works with the main PPP driver
> -	  <file:drivers/net/ppp_generic.c> and pppd program.
> -	  HDLC/SYNCPPP support allows use of the Cisco HDLC/PPP driver
> -	  <file:drivers/net/wan/syncppp.c>. The SyncLink WAN driver (in
> -	  character devices) must also be enabled.
> -
>  # Generic HDLC
>  config HDLC
>  	tristate "Generic HDLC layer"

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

