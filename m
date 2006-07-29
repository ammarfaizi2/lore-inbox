Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWG2R5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWG2R5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWG2R5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:57:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60059 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932197AbWG2R5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:57:50 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44CBA0F3.5020908@s5r6.in-berlin.de>
Date: Sat, 29 Jul 2006 19:54:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the scheduled removal of drivers/ieee1394/sbp2.c:force_inquiry_hack
References: <20060729174828.GC26963@stusta.de>
In-Reply-To: <20060729174828.GC26963@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the scheduled removal of the force_inquiry_hack 
> module parameter.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

How the time flies. Thanks.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

> ---
> 
>  Documentation/feature-removal-schedule.txt |    9 ---------
>  drivers/ieee1394/sbp2.c                    |   10 ----------
>  2 files changed, 19 deletions(-)
> 
> --- linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-07-27 20:36:51.000000000 +0200
> +++ linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt	2006-07-27 20:37:00.000000000 +0200
> @@ -23,15 +23,6 @@
>  
>  ---------------------------
>  
> -What:	sbp2: module parameter "force_inquiry_hack"
> -When:	July 2006
> -Why:	Superceded by parameter "workarounds". Both parameters are meant to be
> -	used ad-hoc and for single devices only, i.e. not in modprobe.conf,
> -	therefore the impact of this feature replacement should be low.
> -Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
> -
> ----------------------------
> -
>  What:	Video4Linux API 1 ioctls and video_decoder.h from Video devices.
>  When:	July 2006
>  Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to 2.6
> --- linux-2.6.18-rc2-mm1-full/drivers/ieee1394/sbp2.c.old	2006-07-27 20:37:10.000000000 +0200
> +++ linux-2.6.18-rc2-mm1-full/drivers/ieee1394/sbp2.c	2006-07-27 20:37:23.000000000 +0200
> @@ -173,11 +173,6 @@
>  	", override internal blacklist = " __stringify(SBP2_WORKAROUND_OVERRIDE)
>  	", or a combination)");
>  
> -/* legacy parameter */
> -static int force_inquiry_hack;
> -module_param(force_inquiry_hack, int, 0644);
> -MODULE_PARM_DESC(force_inquiry_hack, "Deprecated, use 'workarounds'");
> -
>  /*
>   * Export information about protocols/devices supported by this driver.
>   */
> @@ -1554,11 +1549,6 @@
>  	}
>  
>  	workarounds = sbp2_default_workarounds;
> -	if (force_inquiry_hack) {
> -		SBP2_WARN("force_inquiry_hack is deprecated. "
> -			  "Use parameter 'workarounds' instead.");
> -		workarounds |= SBP2_WORKAROUND_INQUIRY_36;
> -	}
>  
>  	if (!(workarounds & SBP2_WORKAROUND_OVERRIDE))
>  		for (i = 0; i < ARRAY_SIZE(sbp2_workarounds_table); i++) {
> 


-- 
Stefan Richter
-=====-=-==- -=== ===-=
http://arcgraph.de/sr/
