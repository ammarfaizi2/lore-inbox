Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTBCJY1>; Mon, 3 Feb 2003 04:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBCJY1>; Mon, 3 Feb 2003 04:24:27 -0500
Received: from gate.perex.cz ([194.212.165.105]:29967 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S264665AbTBCJY0>;
	Mon, 3 Feb 2003 04:24:26 -0500
Date: Mon, 3 Feb 2003 10:33:35 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Resource Management Improvements (1/4)
In-Reply-To: <20030202203641.GA22089@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302031032560.4023-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Adam Belay wrote:

> @@ -825,10 +825,10 @@
>  
>          } /* while */
>  	end:
> -	if (pnp_port_valid(dev, 0) == 0 &&
> -	    pnp_mem_valid(dev, 0) == 0 &&
> -	    pnp_irq_valid(dev, 0) == 0 &&
> -	    pnp_dma_valid(dev, 0) == 0)
> +	if (pnp_port_start(dev, 0) == 0 &&
> +	    pnp_mem_start(dev, 0) == 0 &&
> +	    pnp_irq(dev, 0) == -1 &&
> +	    pnp_dma(dev, 0) == -1)
>  		dev->active = 0;
>  	else
>  		dev->active = 1;

Again, why this?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

