Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUBDMYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 07:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUBDMYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 07:24:36 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:12672 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S262153AbUBDMYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 07:24:35 -0500
Date: Wed, 4 Feb 2004 13:24:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Sun Keyboard driver
Message-ID: <20040204122403.GA447@ucw.cz>
References: <20040204115128.GA25798@badne4.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204115128.GA25798@badne4.ux.his.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:51:28PM +0100, Erlend Aasland wrote:
> Hi,
> 
> I noticed a small bug in the sunkbd.c driver: After the keyboard name is
> set, it is mistakenly overwritten by serio->phys. Path is against 2.6.2.

Thanks for noticing, it's already fixed in my tree.

> 
> Regards,
> 		Erlend Aasland
> 
> --- drivers/input/keyboard/sunkbd.c~	2004-02-04 13:06:44.603610000 +0100
> +++ drivers/input/keyboard/sunkbd.c	2004-02-04 13:09:00.603610000 +0100
> @@ -275,7 +275,7 @@
>  		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
>  	clear_bit(0, sunkbd->dev.keybit);
>  
> -	sprintf(sunkbd->name, "%s/input", serio->phys);
> +	sprintf(sunkbd->phys, "%s/input", serio->phys);
>  
>  	sunkbd->dev.name = sunkbd->name;
>  	sunkbd->dev.phys = sunkbd->phys;
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
