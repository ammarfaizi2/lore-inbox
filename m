Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWATWUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWATWUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWATWUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:20:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:527 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932243AbWATWUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:20:07 -0500
Date: Fri, 20 Jan 2006 23:19:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4.32] usb-uhci.c failing "-"
Message-ID: <20060120221943.GS7142@w.ods.org>
References: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 09:33:26AM +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> Looks like a bug?

Looks like you're right.

Marcelo, I've merged it into -upstream.

> Thanks
> Guennadi

Thanks,
Willy

> ---------------------------------
> Guennadi Liakhovetski, Ph.D.
> DSA Daten- und Systemtechnik GmbH
> Pascalstr. 28
> D-52076 Aachen
> Germany
> 
> Signed-off-by Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> --- a/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:27:50 2006
> +++ b/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:28:05 2006
> @@ -2505,7 +2505,7 @@
>  			((urb_priv_t*)urb->hcpriv)->flags=0;
>  		}
> 
> -		if ((urb->status != -ECONNABORTED) && (urb->status != 
> ECONNRESET) &&
> +		if ((urb->status != -ECONNABORTED) && (urb->status != 
> -ECONNRESET) &&
>  			    (urb->status != -ENOENT)) {
> 
>  			urb->status = -EINPROGRESS;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
