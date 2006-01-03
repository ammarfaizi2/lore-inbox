Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWACNWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWACNWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWACNWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:22:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:34497 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932295AbWACNV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:21:59 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de>
From: Andi Kleen <ak@suse.de>
Date: 03 Jan 2006 14:21:34 +0100
In-Reply-To: <20050726150837.GT3160@stusta.de>
Message-ID: <p7364p1jvkx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:
> 
>  Documentation/feature-removal-schedule.txt |    7 +
>  sound/oss/Kconfig                          |   79 ++++++++++++---------
>  2 files changed, 54 insertions(+), 32 deletions(-)
> 
> --- linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-07-26 16:50:05.000000000 +0200
> +++ linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt	2005-07-26 16:51:24.000000000 +0200
> @@ -44,0 +45,7 @@
> +What:	drivers depending on OBSOLETE_OSS_DRIVER
> +When:	October 2005
> +Why:	OSS drivers with ALSA replacements
> +Who:	Adrian Bunk <bunk@stusta.de>

I object to the ICH driver being scheduler for removal. It works
fine and is a significantly less bloated than the equivalent ALSA setup.

This means ac97_codec.c also has to stay.

-Andi
