Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVGZPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVGZPld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVGZPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:41:33 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:4401 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261857AbVGZPlb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:41:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cdm1HnKbb7bZklxpWbbh0HxfzV0JFbeA+h7lRVGK9/jE5zfiZ2CQQeqPS3UU59hjVH4nG92hXJlwIG6sahnELhRYyPtGrX302CPn8UBYfZQyIG0J3rZMqKgrys6cMjFKWFj926jr5Z4dCQkyf9DEceEJBHG26ZASGsykLRxWhu8=
Message-ID: <9a8748490507260841698859e4@mail.gmail.com>
Date: Tue, 26 Jul 2005 17:41:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
In-Reply-To: <20050726150837.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726150837.GT3160@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/05, Adrian Bunk <bunk@stusta.de> wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that
> support the same hardware) for removal.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> I've Cc'ed the people listed in MAINTAINERS as being responsible for one
> or more of these drivers, and I've also Cc'ed the ALSA people.
> 
> Please tell if any my driver selections is wrong.
> 
>  Documentation/feature-removal-schedule.txt |    7 +
>  sound/oss/Kconfig                          |   79 ++++++++++++---------
>  2 files changed, 54 insertions(+), 32 deletions(-)
> 
> --- linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt.old    2005-07-26 16:50:05.000000000 +0200
> +++ linux-2.6.13-rc3-mm1-full/Documentation/feature-removal-schedule.txt        2005-07-26 16:51:24.000000000 +0200
> @@ -44,0 +45,7 @@
> +What:  drivers depending on OBSOLETE_OSS_DRIVER
> +When:  October 2005
> +Why:   OSS drivers with ALSA replacements
> +Who:   Adrian Bunk <bunk@stusta.de>
> +
> +---------------------------
> +
> --- linux-2.6.13-rc3-mm1-modular/sound/oss/Kconfig.old  2005-07-23 21:04:56.000000000 +0200
> +++ linux-2.6.13-rc3-mm1-modular/sound/oss/Kconfig      2005-07-24 01:22:11.000000000 +0200
> @@ -4,9 +4,24 @@
>  # More hacking for modularisation.
>  #
>  # Prompt user for primary drivers.
> +
> +config OBSOLETE_OSS_DRIVER
> +       bool "Obsolete OSS drivers"
> +       depends on SOUND_PRIME
> +       help
> +         This patch enables support for obsolete OSS drivers that

                      s/patch/option/  ???

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
