Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVJODWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVJODWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 23:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVJODWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 23:22:12 -0400
Received: from pop-borzoi.atl.sa.earthlink.net ([207.69.195.70]:18136 "EHLO
	pop-borzoi.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750945AbVJODWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 23:22:12 -0400
From: Wilson Michaels <wilsonmichaels@earthlink.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH 08/14] Big kfree NULL check cleanup - drivers/media
Date: Fri, 14 Oct 2005 22:21:06 -0500
User-Agent: KMail/1.8.1
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Manu Abraham <manu@kromtek.com>,
       Emard <emard@softhome.net>, Marko Kohtala <marko.kohtala@luukku.com>,
       Andreas Oberritter <obi@linuxtv.org>,
       Kirk Lapray <kirk_lapray@bigfoot.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Takeo Takahashi <takahashi.takeo@renesas.com>,
       Ralph Metzler <rjkm@thp.uni-koeln.de>, Gerd Knorr <kraxel@bytesex.org>,
       Bill Dirks <bdirks@pacbell.net>, Wolfgang Scherr <scherr@net4you.at>,
       Alan Cox <alan@redhat.com>, Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Serguei Miridonov <mirsev@cicese.mx>
References: <200510132128.12616.jesper.juhl@gmail.com>
In-Reply-To: <200510132128.12616.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510142221.07341.wilsonmichaels@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 October 2005 02:28 pm, Jesper Juhl wrote:
> This is the drivers/media/ part of the big kfree cleanup
> patch.
>
> Remove pointless checks for NULL prior to calling kfree()
> in drivers/media/.
>
>
> Sorry about the long Cc: list, but I wanted to make sure
> I included everyone who's code I've changed with this
> patch.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
> Please see the initial announcement mail on LKML with
> subject "[PATCH 00/14] Big kfree NULL check cleanup"
> for additional details.
>

> linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/lgdt330
>x.c	2005-10-11 22:41:09.000000000 +0200 +++
> linux-2.6.14-rc4/drivers/media/dvb/frontends/lgdt330x.c	2
>005-10-13 10:28:41.000000000 +0200 @@ -729,8 +729,7 @@
> struct dvb_frontend* lgdt330x_attach(con return
> &state->frontend;
>
>  error:
> -	if (state)
> -		kfree(state);
> +	kfree(state);
>  	dprintk("%s: ERROR\n",__FUNCTION__);
>  	return NULL;
>  }
> ---

Acked-by : Wilson Michaels <wilsonmichaels@earthlink.net>
