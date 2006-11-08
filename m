Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423794AbWKHWNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423794AbWKHWNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161742AbWKHWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:13:25 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:35765 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S1161737AbWKHWNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:13:24 -0500
Message-ID: <45525712.8020103@acm.org>
Date: Wed, 08 Nov 2006 16:15:46 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si_intf.c: fix "&& 0xff" typos
References: <20061108220925.GB4972@martell.zuzino.mipt.ru>
In-Reply-To: <20061108220925.GB4972@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch, I guess we've never had a system with these address types.  Thanks.

-Corey

Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  drivers/char/ipmi/ipmi_si_intf.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1211,7 +1211,7 @@ static void intf_mem_outb(struct si_sm_i
>  static unsigned char intf_mem_inw(struct si_sm_io *io, unsigned int offset)
>  {
>  	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
> -		&& 0xff;
> +		& 0xff;
>  }
>  
>  static void intf_mem_outw(struct si_sm_io *io, unsigned int offset,
> @@ -1223,7 +1223,7 @@ static void intf_mem_outw(struct si_sm_i
>  static unsigned char intf_mem_inl(struct si_sm_io *io, unsigned int offset)
>  {
>  	return (readl((io->addr)+(offset * io->regspacing)) >> io->regshift)
> -		&& 0xff;
> +		& 0xff;
>  }
>  
>  static void intf_mem_outl(struct si_sm_io *io, unsigned int offset,
> @@ -1236,7 +1236,7 @@ #ifdef readq
>  static unsigned char mem_inq(struct si_sm_io *io, unsigned int offset)
>  {
>  	return (readq((io->addr)+(offset * io->regspacing)) >> io->regshift)
> -		&& 0xff;
> +		& 0xff;
>  }
>  
>  static void mem_outq(struct si_sm_io *io, unsigned int offset,
>   

