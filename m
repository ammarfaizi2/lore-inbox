Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVKUCUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVKUCUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 21:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVKUCUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 21:20:10 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:41857 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932178AbVKUCUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 21:20:09 -0500
Date: Mon, 21 Nov 2005 03:19:25 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>,
       Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
       linux-dvb-maintainer@linuxtv.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Message-ID: <20051121021925.GC7175@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Denis Vlasenko <vda@ilport.com.ua>,
	"Cipriani, Lawrence V (Larry)" <lvc@lucent.com>,
	Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
	linux-dvb-maintainer@linuxtv.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com> <200511171500.06910.vda@ilport.com.ua> <20051120020115.GA8157@linuxtv.org> <200511201327.23475.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511201327.23475.vda@ilport.com.ua>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.242.166
Subject: Re: [linux-dvb-maintainer] [PATCH] Re: bugs in /usr/src/linux/net/ipv6/mcast.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 01:27:23PM +0200, Denis Vlasenko wrote:
> On Sunday 20 November 2005 04:01, Johannes Stezenbach wrote:
> > Can you add your Signed-off-by: ?
> 
> Sure.
> 
> Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>

Thanks, I added this patch to linuxtv.org CVS.

We'll see if this fix actually improves or breaks the driver ;-/

Johannes

> diff -urpN linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c
> --- linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c	Sat Nov  5 15:17:30 2005
> +++ linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c	Thu Nov 17 14:41:05 2005
> @@ -140,25 +140,25 @@ static int ves1820_set_symbolrate(struct
>  	/* yeuch! */
>  	fpxin = state->config->xin * 10;
>  	fptmp = fpxin; do_div(fptmp, 123);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 1;
>  	fptmp = fpxin; do_div(fptmp, 160);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 0;
>  	fptmp = fpxin; do_div(fptmp, 246);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 1;
>  	fptmp = fpxin; do_div(fptmp, 320);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 0;
>  	fptmp = fpxin; do_div(fptmp, 492);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 1;
>  	fptmp = fpxin; do_div(fptmp, 640);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 0;
>  	fptmp = fpxin; do_div(fptmp, 984);
> -	if (symbolrate < fptmp);
> +	if (symbolrate < fptmp)
>  		SFIL = 1;
>  
>  	fin = state->config->xin >> 4;

