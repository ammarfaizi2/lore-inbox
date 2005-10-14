Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVJNV4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVJNV4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVJNV4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:56:22 -0400
Received: from ffm.saftware.de ([217.20.127.95]:27411 "EHLO ffm.saftware.de")
	by vger.kernel.org with ESMTP id S1750924AbVJNV4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:56:22 -0400
Subject: Re: [PATCH 08/14] Big kfree NULL check cleanup - drivers/media
From: Andreas Oberritter <obi@linuxtv.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@kromtek.com>,
       Emard <emard@softhome.net>, Marko Kohtala <marko.kohtala@luukku.com>,
       Wilson Michaels <wilsonmichaels@earthlink.net>,
       Kirk Lapray <kirk_lapray@bigfoot.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       video4linux-list@redhat.com,
       Takeo Takahashi <takahashi.takeo@renesas.com>,
       Ralph Metzler <rjkm@thp.uni-koeln.de>, Gerd Knorr <kraxel@bytesex.org>,
       Bill Dirks <bdirks@pacbell.net>, Wolfgang Scherr <scherr@net4you.at>,
       Alan Cox <alan@redhat.com>, Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Serguei Miridonov <mirsev@cicese.mx>
In-Reply-To: <200510132128.12616.jesper.juhl@gmail.com>
References: <200510132128.12616.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 23:56:18 +0200
Message-Id: <1129326978.7184.3.camel@ip6-localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 21:28 +0200, Jesper Juhl wrote:
> This is the drivers/media/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in drivers/media/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 

[...]

> --- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/mt312.c	2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/media/dvb/frontends/mt312.c	2005-10-13 10:28:50.000000000 +0200
> @@ -675,8 +675,7 @@ struct dvb_frontend* mt312_attach(const 
>  	return &state->frontend;
>  
>  error:
> -	if (state)
> -		kfree(state);
> +	kfree(state);
>  	return NULL;
>  }
>  

Acked-by: Andreas Oberritter <obi@linuxtv.org>


