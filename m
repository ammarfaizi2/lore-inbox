Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWHBP4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWHBP4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHBP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:56:55 -0400
Received: from kurby.webscope.com ([204.141.84.54]:34450 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751214AbWHBP4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:56:54 -0400
Message-ID: <44D0CB36.3050303@linuxtv.org>
Date: Wed, 02 Aug 2006 11:56:38 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: akpm@osdl.org, jayakumar.video@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: quickcam_messenger compilation fix
References: <20060802163004.6ebf2cd7.diegocg@gmail.com>
In-Reply-To: <20060802163004.6ebf2cd7.diegocg@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> In bugzilla #6943, Maxim Britov reported:
> 
> "I can enable Logitech quickcam support in .config, but it want be compile.
> I have to add into drivers/media/video/Makefile:
> obj-$(CONFIG_USB_QUICKCAM_MESSENGER)    += usbvideo/"
> 
> He's right, just enable that driver as module while disabling every other
> driver that gets into that directory, nothing will get compiled.
> This patch fixes the Makefile.
> 
> Signed-off-by: Diego Calleja <diegocg@gmail.com>
> 
> Index: 2.6/drivers/media/video/Makefile
> ===================================================================
> --- 2.6.orig/drivers/media/video/Makefile	2006-08-02 16:22:40.000000000 +0200
> +++ 2.6/drivers/media/video/Makefile	2006-08-02 16:22:51.000000000 +0200
> @@ -91,6 +91,7 @@
>  obj-$(CONFIG_USB_IBMCAM)        += usbvideo/
>  obj-$(CONFIG_USB_KONICAWC)      += usbvideo/
>  obj-$(CONFIG_USB_VICAM)         += usbvideo/
> +obj-$(CONFIG_USB_QUICKCAM_MESSENGER)	+= usbvideo/
>  
>  obj-$(CONFIG_VIDEO_VIVI) += vivi.o
>  

Acked-by: Michael Krufky <mkrufky@linuxtv.org>

