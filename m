Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269215AbUISLrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269215AbUISLrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUISLrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 07:47:17 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:11911 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S269215AbUISLrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 07:47:15 -0400
Date: Sun, 19 Sep 2004 13:46:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydump needs gameport
Message-ID: <20040919114643.GA5458@ucw.cz>
References: <20040918142916.GA16203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040918142916.GA16203@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 04:29:16PM +0200, Olaf Hering wrote:
> 
> joydump needs gameport:
> 
> WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_register_device
> WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_unregister_device
> WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_open
> WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_close
> 
> 
> --- ./drivers/input/joystick/Kconfig.orig	2004-09-18 16:14:49.734444000 +0200
> +++ ./drivers/input/joystick/Kconfig	2004-09-18 16:26:29.458176128 +0200
> @@ -249,7 +249,7 @@ config JOYSTICK_AMIGA
>  
>  config JOYSTICK_JOYDUMP
>  	tristate "Gameport data dumper"
> -	depends on INPUT && INPUT_JOYSTICK
> +	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
>  	help
>  	  Say Y here if you want to dump data from your joystick into the system
>  	  log for debugging purposes. Say N if you are making a production
 
Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
