Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbTGIJlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbTGIJlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:41:10 -0400
Received: from vitelus.com ([64.81.243.207]:49317 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S268130AbTGIJlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:41:08 -0400
Date: Wed, 9 Jul 2003 02:55:44 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make synaptics support optional
Message-ID: <20030709095544.GA852@vitelus.com>
References: <20030708104551.GA209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708104551.GA209@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 12:45:51PM +0200, Pavel Machek wrote:
> --- /usr/src/tmp/linux/drivers/input/mouse/synaptics.c	2003-06-24 12:27:47.000000000 +0200
> +++ /usr/src/linux/drivers/input/mouse/synaptics.c	2003-07-08 12:32:36.000000000 +0200
> @@ -213,6 +213,9 @@
>  {
>  	struct synaptics_data *priv;
>  
> +#ifndef CONFIG_MOUSE_SYNAPTICS
> +	return -1;
> +#endif;
>  	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
>  	if (!priv)
>  		return -1;
> 

Why not adjust the Makefiles?
