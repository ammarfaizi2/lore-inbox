Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWCLTvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCLTvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 14:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWCLTvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 14:51:02 -0500
Received: from outmx006.isp.belgacom.be ([195.238.4.99]:14784 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932152AbWCLTvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 14:51:01 -0500
Date: Sun, 12 Mar 2006 20:50:47 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/watchdog/pcwd_usb.c: fix a NULL pointer dereference
Message-ID: <20060312195047.GA4234@infomag.infomag.iguana.be>
References: <20060310180438.GQ21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310180438.GQ21864@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> The Coverity checker noted that this resulted in a NULL pointer 
> reference if we were coming from
> 
>         if (usb_pcwd == NULL) {
>                 printk(KERN_ERR PFX "Out of memory\n");
>                 goto error;
>         }
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

This is indeed a bug. I added this patch into my linux-2.6-watchdog-mm tree and I have tested it positively with a PCWD-USB card.

Thanks,
Wim.

