Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWGAXMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWGAXMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGAXMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:12:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51972 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751563AbWGAXMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:12:17 -0400
Date: Sun, 2 Jul 2006 01:12:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz, Olaf Hering <olh@suse.de>,
       linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: OSS driver removal, 2nd round
Message-ID: <20060701231216.GG17588@stusta.de>
References: <20060629192128.GE19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629192128.GE19712@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 09:21:28PM +0200, Adrian Bunk wrote:

> Now that I've sent the first round of actually removing the code for OSS 
> drivers where ALSA drivers without regressions exist for the same 
> hardware, it's time for a second round amongst the remaining drivers.
> 
> 
> Removing OSS drivers where ALSA drivers for the same hardware exists has 
> two reasons:
> 
> 1. remove obsolete and mostly unmaintained code
> 2. get bugs in the ALSA drivers reported that weren't previously
>    reported due to the possible workaround of using the OSS drivers
> 
> 
> The list below divides the OSS drivers into the following three
> categories:
> 1. ALSA drivers for the same hardware
> 2. ALSA drivers for the same hardware with known problems
> 3. no ALSA drivers for the same hardware
> 
> 
> My proposed timeline is:
> - 2.6.18: let the drivers under 1. in the list below depend on
>           OSS_OBSOLETE_DRIVER
> - 2.6.20: remove the options depending on OSS_OBSOLETE_DRIVER
> - 2.6.22: remove the code for the drivers that were depending on
>           OSS_OBSOLETE_DRIVER from the kernel tree
>...
> 2. ALSA drivers for the same hardware with known problems
> 
> DMASOUND_PMAC
> - Olaf Hering regarding regressions in SND_POWERMAC:
>   Some tumbler models work only after one plug/unplug cycle of
>   the headphone. early powerbooks report/handle the mute settings
>   incorrectly. there are likely more bugs.
>...

Could anyone tell me whether there are still regressions in ALSA 
compared to DMASOUND_PMAC, and if yes give me bug numbers in the 
ALSA BTS so that I can track them?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

