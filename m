Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSGYOQI>; Thu, 25 Jul 2002 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSGYOQH>; Thu, 25 Jul 2002 10:16:07 -0400
Received: from fysh.org ([212.47.68.126]:23754 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S314459AbSGYOQH>;
	Thu, 25 Jul 2002 10:16:07 -0400
Date: Thu, 25 Jul 2002 15:19:22 +0100
From: Athanasius <link@gurus.tf>
To: Alan Cox <alan@irongate.swansea.linux.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.5.28 Fix other peoples ALSA PCI fixe
Message-ID: <20020725141922.GE4345@miggy.org.uk>
Mail-Followup-To: Athanasius <link@gurus.tf>,
	Alan Cox <alan@irongate.swansea.linux.org.uk>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200207251449.g6PEngGW010478@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207251449.g6PEngGW010478@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:49:42PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/ice1712.c linux-2.5.28-ac1/sound/pci/ice1712.c
> --- linux-2.5.28/sound/pci/ice1712.c	Thu Jul 25 10:51:01 2002
> +++ linux-2.5.28-ac1/sound/pci/ice1712.c	Thu Jul 25 13:09:37 2002
> @@ -4070,8 +4070,8 @@
>  	/* --- */
>        __hw_end:
>  	snd_ice1712_proc_done(ice);
> -	synchronize_irq();
>  	if (ice->irq)
        ^^
> +		synchronize_irq(ice->irq);
>  		free_irq(ice->irq, (void *) ice);
>  	if (ice->res_port) {
>  		release_resource(ice->res_port);

   Um, need some {} on that if now ?

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
