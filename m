Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWBAAg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWBAAg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBAAg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:36:59 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:58086 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWBAAg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:36:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pMrmRILG0mTcIzYO7AyFJdoJlcoCwAo1GlEqZN/OlVdjv1l34TSO0CbU+ErTdrUTyBBH99Q0+rqxdM2lQfVN0MuYUjLE1THh0feyGK+RUSsF7Vxs5dh+bgjcJs3A17kmLLr96QqZYBz5j3Fej9j04/YN5hdtwEjvhqZa77p+4JE=
Message-ID: <43E00291.5050507@gmail.com>
Date: Wed, 01 Feb 2006 08:36:33 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: vgacon scrolling problem [Was: Re: 2.6.16-rc1-mm4]
References: <drln68$n82$1@sea.gmane.org> <20060131202454.CDC2322AEAC@anxur.fi.muni.cz> <drohmk$itt$1@sea.gmane.org>
In-Reply-To: <drohmk$itt$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka wrote:
> Jiri Slaby wrote:
>> Jindrich Makovicka wrote:
>>
>>> In vgacon.c, there is a stray printk("vgacon delta: %i\n", lines); which
>>> effectively disables the scrollback of the vga console (at least when
>>> not using the new soft scrollback). Removing it fixes the problem.
>> Then ... could you post a patch?
> 
> if you insist :)

Sorry about that, thanks for noticing.

Acked-by: Antonino Daplas <adaplas@pol.net>

> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-25 19:16:35.000000000 +0100
> +++ linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-31 21:33:40.433055896 +0100
> @@ -331,7 +331,6 @@
>  		int margin = c->vc_size_row * 4;
>  		int ul, we, p, st;
>  
> -		printk("vgacon delta: %i\n", lines);
>  		if (vga_rolled_over >
>  		    (c->vc_scr_end - vga_vram_base) + margin) {
>  			ul = c->vc_scr_end - vga_vram_base;

