Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWJIUwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWJIUwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWJIUwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:52:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964850AbWJIUwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:52:20 -0400
Subject: Re: pvrusb2 and 2.6.19-rc1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Mike Isely at pobox <isely@pobox.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4527FF78.4050309@linuxtv.org>
References: <Pine.LNX.4.64.0610071138100.27957@cnc.isely.net>
	 <4527FF78.4050309@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 09 Oct 2006 17:50:42 -0300
Message-Id: <1160427043.8620.121.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-10-07 às 15:26 -0400, Michael Krufky escreveu:
> Mike Isely wrote:
> > Mauro:
> >
> > Why are the pvrusb2 configuration switches nowhere to be found in 
> > 2.6.19-rc1?  I'm running xconfig here and searching reverse-deps to try 
> > and locate it.  Best I can tell is that it's gone.  The driver sources are 
> > still present.  What's going on?
> >   
> Mauro, please pull from:
> 
> |git://git.kernel.org/pub/scm/linux/kernel/git/mkrufky/v4l-dvb.git
> 
> to fix the issue described by Mike Isely, above... ||or just apply the
> attached patch to your git tree and send to Linus.|
> |
> This problem is only present in your git tree -- the hg tree is in good
> shape.  How did this happen, Mauro?

Fixed, and included at my tree. I'll ask Linus to pull with the next
patchsets.

> 
> Regards,
> 
> Michael Krufky
> 
> 
> |
> anexo Documento somente texto
> (0001-Kconfig-restore-pvrusb2-menu-items.txt)
> From 9ce12c8763cc244725dec99085efd293483c6bf8 Mon Sep 17 00:00:00 2001
> From: Michael Krufky <mkrufky@linuxtv.org>
> Date: Sat, 7 Oct 2006 15:10:53 -0400
> Subject: [PATCH] Kconfig: restore pvrusb2 menu items
> 
> Looks like the pvrusb2 menu items were accidentally removed in
> git commit 1450e6bedc58c731617d99b4670070ed3ccc91b4
> 
> This patch restores the menu items so that the pvrusb2 driver can be built.
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> ---
>  drivers/media/video/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
> index afb734d..fbe5b61 100644
> --- a/drivers/media/video/Kconfig
> +++ b/drivers/media/video/Kconfig
> @@ -677,6 +677,8 @@ #
>  menu "V4L USB devices"
>  	depends on USB && VIDEO_DEV
>  
> +source "drivers/media/video/pvrusb2/Kconfig"
> +
>  source "drivers/media/video/em28xx/Kconfig"
>  
>  source "drivers/media/video/usbvideo/Kconfig"
Cheers, 
Mauro.

