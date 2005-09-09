Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVIIWUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVIIWUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVIIWUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:20:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:30352 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932583AbVIIWU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:20:28 -0400
Date: Fri, 9 Sep 2005 15:11:58 -0700
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] W1 patches for 2.6.13
Message-ID: <20050909221158.GA30321@kroah.com>
References: <20050908222105.GA6633@kroah.com> <1126222209.5286.74.camel@blade> <20050909033036.GB11369@suse.de> <20050909050825.GA16668@2ka.mipt.ru> <20050909211619.GA28696@kroah.com> <20050909215814.GA6022@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909215814.GA6022@2ka.mipt.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 01:58:14AM +0400, Evgeniy Polyakov wrote:
> I'm sorry - quite far from testing machines...
> Here is additional patch for ds_2433.c - it adds two missing defines.
> 
> --- ./drivers/w1/w1_ds2433.c.orig	2005-09-10 01:59:41.000000000 +0400
> +++ ./drivers/w1/w1_ds2433.c	2005-09-10 01:57:41.000000000 +0400
> @@ -15,6 +15,10 @@
>  #include <linux/delay.h>
>  #ifdef CONFIG_W1_F23_CRC
>  #include <linux/crc16.h>
> +
> +#define CRC16_INIT		0
> +#define CRC16_VALID		0xb001
> +

Ick, care to just respin the whole patch, with a proper Subject: and
signed-off-line?

thanks,

greg k-h
