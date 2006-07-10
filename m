Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWGJNCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWGJNCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWGJNCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:02:39 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:50100 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161053AbWGJNCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hQXoiYhhUMKZeLMK0EZW9Pudg4oRWInpa17gxH7H4U4PeAjJFX1Nt7peSKJJgRsPHveyr4C2qbScYgM+BiEW1dRcPc2wPm1g+uxSvNXsLaYXOQ8ZOpoOAXoP1BS9Fz0b/wPUwGT8JW/uvXN7uYhDA46KCX4JXGDnB1xNf/rTbzk=
Message-ID: <44B24FE7.2050807@gmail.com>
Date: Mon, 10 Jul 2006 21:02:31 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
References: <200607100833.00461.mreuther@umich.edu>
In-Reply-To: <200607100833.00461.mreuther@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
> The following errors show up on 'make modules_install' for the 2.6.18-rc1-mm1 
> kernel. The snd-miro ones have actually been there since at least 2.6.17.4, 
> and they show up in 2.6.18-rc1 as well.

> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_unregister_client
> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
> needs unknown symbol fb_register_client
> 

CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?

Tony

