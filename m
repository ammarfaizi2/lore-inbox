Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTBCGgb>; Mon, 3 Feb 2003 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBCGgb>; Mon, 3 Feb 2003 01:36:31 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:23304 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265982AbTBCGga>; Mon, 3 Feb 2003 01:36:30 -0500
Message-Id: <200302030638.h136cXs04904@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PnP BIOS cleanups (4/4)
Date: Mon, 3 Feb 2003 08:36:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jaroslav Kysela <perex@perex.cz>
References: <20030202203656.GA23160@neo.rr.com>
In-Reply-To: <20030202203656.GA23160@neo.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 February 2003 22:36, Adam Belay wrote:
> This patch cleans up device inserting and disabling.
>
>
> --- a/drivers/pnp/pnpbios/core.c	Sun Feb  2 18:43:34 2003
> +++ b/drivers/pnp/pnpbios/core.c	Sun Feb  2 19:19:13 2003
> @@ -236,6 +236,7 @@
>  	void *p = kmalloc( size, f );
>  	if ( p == NULL )
>  		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
> +	memset(p, 0, size);
>  	return p;
>  }

Erm... so you can memset an area pointed by a NULL pointer here?
--
vda
