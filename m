Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbSJHAf5>; Mon, 7 Oct 2002 20:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHAf4>; Mon, 7 Oct 2002 20:35:56 -0400
Received: from dp.samba.org ([66.70.73.150]:31874 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262687AbSJHAfB>;
	Mon, 7 Oct 2002 20:35:01 -0400
Date: Tue, 8 Oct 2002 10:40:31 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Wichert Akkerman <wichert@wiggy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 orinoco_cs.c compile failure
Message-ID: <20021008004031.GB32555@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Wichert Akkerman <wichert@wiggy.net>, linux-kernel@vger.kernel.org
References: <20021007210817.GD14953@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007210817.GD14953@wiggy.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:08:17PM +0200, Wichert Akkerman wrote:
> Compile fails since orinoco_cs.c tries to use the no longer existing
> linux/tqueue.h header. Patch below seems to fix it. 

Appears to be fixed already.

> +++ drivers/net/wireless/orinoco_cs.c	2002-10-07 23:04:16.000000000 +0200
> @@ -32,7 +32,7 @@
>  #include <linux/if_arp.h>
>  #include <linux/etherdevice.h>
>  #include <linux/wireless.h>
> -#include <linux/tqueue.h>
> +#include <linux/workqueue.h>
>  
>  #include <pcmcia/version.h>
>  #include <pcmcia/cs_types.h>
> 

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
