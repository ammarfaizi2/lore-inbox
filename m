Return-Path: <linux-kernel-owner+w=401wt.eu-S1751131AbWLNHFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWLNHFF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWLNHFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:05:04 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:56437 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbWLNHFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:05:03 -0500
X-Greylist: delayed 1493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 02:05:03 EST
Date: Thu, 14 Dec 2006 08:40:02 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] updated proper-backlight-selection-for-fbdev-drivers.patch
Message-ID: <20061214064002.GB12910@sci.fi>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612131530340.4484@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0612131530340.4484@pentafluge.infradead.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 03:32:09PM +0000, James Simmons wrote:
> 
> Signed-Off-By: James Simmons <jsimmons@www.infradead.org>
> 
> Here is the updated patch for proper backlight selection.
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
...
> @@ -1135,8 +1140,7 @@ config FB_ATY_GX
>  
>  config FB_ATY_BACKLIGHT
>  	bool "Support for backlight control"
> -	depends on FB_ATY && PMAC_BACKLIGHT
> -	select FB_BACKLIGHT
> +	depends on FB_ATY
>  	default y
>  	help
>  	  Say Y here if you want to control the backlight of your display.

Is there some non-Mac hardware on which the backlight control actually 
works? IIRC I tried it on some x86 laptops at some point and it didn't 
do anything, and that is why I added the generic backlight voltage 
on/off thing. Just to be sure I can re-test my laptops next weekend...

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
