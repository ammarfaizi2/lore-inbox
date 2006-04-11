Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWDKEEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWDKEEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 00:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWDKEEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 00:04:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50578 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751226AbWDKEEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 00:04:10 -0400
Subject: Re: [Patch] Overrun in sound/pci/au88x0/au88x0_pcm.c
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <1144664001.15821.1.camel@alice>
References: <1144664001.15821.1.camel@alice>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 00:03:56 -0400
Message-Id: <1144728237.18918.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please send all ALSA bug fixes to alsa-devel (cc'ed)

On Mon, 2006-04-10 at 12:13 +0200, Eric Sesterhenn wrote:
> hi,
> 
> since idx is used as an index for vortex_pcm_prettyname[VORTEX_PCM_LAST],
> it should not be equal to VORTEX_PCM_LAST. This fixes coverity bug id #572
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c.orig	2006-04-10 12:10:22.000000000 +0200
> +++ linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c	2006-04-10 12:10:41.000000000 +0200
> @@ -506,7 +506,7 @@ static int __devinit snd_vortex_new_pcm(
>  	int i;
>  	int err, nr_capt;
>  
> -	if ((chip == 0) || (idx < 0) || (idx > VORTEX_PCM_LAST))
> +	if ((chip == 0) || (idx < 0) || (idx >= VORTEX_PCM_LAST))
>  		return -ENODEV;
>  
>  	/* idx indicates which kind of PCM device. ADB, SPDIF, I2S and A3D share the 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

