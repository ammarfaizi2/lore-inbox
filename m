Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUIIWVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUIIWVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUIIWVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:21:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:20643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266615AbUIIWVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:21:14 -0400
Date: Thu, 9 Sep 2004 15:24:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org, petkan@nucleusys.com,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
Message-Id: <20040909152454.14f7ebc9.akpm@osdl.org>
In-Reply-To: <4140256C.5090803@free.fr>
References: <413DB68C.7030508@free.fr>
	<4140256C.5090803@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> Here is a small patch that makes the card functionnal again. I've 
> forwarded the patch to driver author also.
> 
> --- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
> +++ linux/drivers/usb/net/rtl8150.c	2004-09-09 11:15:46.000000000 +0200
> @@ -341,7 +341,7 @@
>  
>  static int rtl8150_reset(rtl8150_t * dev)
>  {
> -	u8 data = 0x11;
> +	u8 data = 0x10;

hm, OK.  Presumably the change (which comes in via the bk-usb tree) was
made for a reason.  So I suspect both versions are wrong ;)

But it might be risky for Greg to merge this patch up at present.

