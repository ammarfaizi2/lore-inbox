Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWDSUDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWDSUDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDSUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:03:30 -0400
Received: from blaster.systems.pipex.net ([62.241.163.7]:43959 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1751214AbWDSUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:03:30 -0400
From: Adam Baker <parport@baker-net.org.uk>
To: linux-parport@lists.infradead.org
Subject: Re: [Linux-parport] [2.6 patch] drivers/parport/share.: unexport parport_get_port
Date: Wed, 19 Apr 2006 21:03:17 +0100
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, philb@gnu.org,
       andrea@suse.de, tim@cyberelk.net, linux-kernel@vger.kernel.org
References: <20060418220720.GQ11582@stusta.de>
In-Reply-To: <20060418220720.GQ11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604192103.17854.parport@baker-net.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 23:07, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(parport_get_port).
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>

It may be unused by any drivers that ship with the kernel but it is used by 
the ppscsi patch to support SCSI over parallel port devices. This export was 
removed in 2.6.10 and put back in in 2.6.16 so someone else obviously thinks 
it should be exported.

> ---
>
> This patch was already sent on:
> - 5 Apr 2006
>
> --- linux-2.6.17-rc1-mm1-full/drivers/parport/share.c.old	2006-04-05
> 17:12:05.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/parport/share.c	2006-04-05
> 17:12:42.000000000 +0200 @@ -1003,7 +1003,6 @@
>  EXPORT_SYMBOL(parport_unregister_driver);
>  EXPORT_SYMBOL(parport_register_device);
>  EXPORT_SYMBOL(parport_unregister_device);
> -EXPORT_SYMBOL(parport_get_port);
>  EXPORT_SYMBOL(parport_put_port);
>  EXPORT_SYMBOL(parport_find_number);
>  EXPORT_SYMBOL(parport_find_base);
>

