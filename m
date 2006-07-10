Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWGJP6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWGJP6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWGJP6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:58:51 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:40655 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422673AbWGJP6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:58:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=i6nhmzpT3DJNq74HyhtMGZa2q58+Qj3VuGg18tPK1VPITE5hybHlVADch3lIoLYIrbvjc/svMzh67q6DBlM14SC3N4+ktjpCo71imfedqtM4tPMQRGOTpWEdihps8WRGCP/11oUl8E3VKojUzb23lNjz37lXgIoUzZQBoPQu/UU=
Message-ID: <44B27931.30609@gmail.com>
Date: Mon, 10 Jul 2006 23:58:41 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
References: <200607100833.00461.mreuther@umich.edu>	<44B24FE7.2050807@gmail.com> <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
In-Reply-To: <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
> Quoting "Antonino A. Daplas" <adaplas@gmail.com>:
> 
>> Matt Reuther wrote:
>>> The following errors show up on 'make modules_install' for the
>>> 2.6.18-rc1-mm1
>>> kernel. The snd-miro ones have actually been there since at least
>>> 2.6.17.4,
>>> and they show up in 2.6.18-rc1 as well.
>>
>>> WARNING:
>>> /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko
>>> needs unknown symbol fb_unregister_client
>>> WARNING:
>>> /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko
>>> needs unknown symbol fb_register_client
>>>
>>
>> CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
>> 2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?
>>
>> Tony
> 
> I am not at the computer right now, but I will try later.
> 
> Here is how I got config-2.6.18-rc1-mm1. I copied this config from
> 2.6.18-rc1, which I had created with 'make menuconfig'. I ran 'make
> oldconfig' on the config-2.6.18-rc1 and answered the new questions to
> generate config-2.6.18-rc1-mm1. I compiled it from there. Does 'make
> oldconfig' not work properly anymore?

I really don't know.  I have received several bug reports where the
main cause was that a kconfig option changed after upgrading kernels.

I tested with make menuconfig, and it's not possible to set lcd/backlight
options if CONFIG_FB is not set.

Tony
