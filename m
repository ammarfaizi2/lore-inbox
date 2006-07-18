Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWGRL4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWGRL4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGRL4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:56:51 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:49822 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751316AbWGRL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:56:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C09w0PDHPBnHRCLrC8kYF+8zrbH/Jh775KlTz1lh5QwFsQBeoUMPyWnx7Qns1aCB1Erow4nUV2LX8x5kDsb8evP2ToAhFwSRWbkbbxXqXXl1oCVpJN0nQS24gD1PwuCIh/Y0s+vmkH4Lf6cHdjW3ufETQXY1i4sR+Rq/ht+7EQI=
Message-ID: <44BCCC7B.7030408@gmail.com>
Date: Tue, 18 Jul 2006 19:56:43 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2: depmod warning for backlight.ko
References: <200607172358.07713.mreuther@umich.edu>
In-Reply-To: <200607172358.07713.mreuther@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
> Hi, Antonino.
> 
> I am still getting warnings on depmod with the 2.6.18-rc2 kernel:
> 
>   INSTALL sound/usb/snd-usb-audio.ko
>   INSTALL sound/usb/snd-usb-lib.ko
>   INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  
> 2.6.18-rc2; fi
> WARNING: /lib/modules/2.6.18-rc2/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_unregister_client
> WARNING: /lib/modules/2.6.18-rc2/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_register_client
> 
> You posted a patch here a few days ago for 2.6.18-rc1-mm1 which fixes this 
> issue. Basically, the USB Apple Cinema display driver selects backlight 
> support, but backlight needs some things from framebuffer, which is turned 
> off. Kconfig does not recursively select CONFIG_FB, so backlight ends up with 
> unresolved symbols.
> 

The patch is still in the -mm tree. They're all in Ottawa right now, so this
will have to wait.

Tony

