Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTFPUGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTFPUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:06:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264203AbTFPUGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:06:10 -0400
Date: Mon, 16 Jun 2003 13:21:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i8253 != rtc
In-Reply-To: <20030616142340.GA369@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306161319310.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jun 2003, Pavel Machek wrote:

> Hi!
> 
>  /* XXX this driverfs stuff should probably go elsewhere later -john
> */
>  static struct sys_device device_i8253 = {
> -       .name           = "rtc",
>         .id             = 0,
> -       .dev    = {
> -               .name   = "i8253 Real Time Clock",
> -       },
> +       .cls    = &rtc_sysclass,
>  };
> 
> ...but i8253 is *not* real time clock. 

D'oh. Noted and changed to 'pit'.


	-pat

