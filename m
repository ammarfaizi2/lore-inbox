Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVKVQdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVKVQdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVKVQdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:33:16 -0500
Received: from [205.233.219.253] ([205.233.219.253]:55445 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S964985AbVKVQdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:33:16 -0500
Date: Tue, 22 Nov 2005 11:32:17 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Jens-Michael Hoffmann <jensmh@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcilynx.c LIndent fixes
Message-ID: <20051122163217.GX20781@conscoop.ottawa.on.ca>
References: <200511220241.44353.jensmh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511220241.44353.jensmh@gmx.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm also sending this to lkml in case people disagree with me or I
missed something.  Should we put something like this in CodingStyle as a
warning to future Lindent users?)

Things that Lindent generally screws up on:

On Tue, Nov 22, 2005 at 02:41:38AM +0000, Jens-Michael Hoffmann wrote:

> -MODULE_PARM_DESC(skip_eeprom, "Use generic bus info block instead of serial eeprom (default = 0).");
> -
> +MODULE_PARM_DESC(skip_eeprom,
> +		 "Use generic bus info block instead of serial eeprom (default = 0).");

String handling.  I guess this is difficult to sensibly automate, but
this should really be something like:

MODULE_PARM_DESC(skip_eeprom,
		 "Use generic bus info block instead of serial eeprom "
		 "(default = 0).");

> [...]

>  static struct i2c_adapter bit_ops = {
> -	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
> -	.client_register	= bit_reg,
> -	.client_unregister	= bit_unreg,
> -	.name			= "PCILynx I2C",
> +	.id = 0xAA,		//FIXME: probably we should get an id in i2c-id.h
> +	.client_register = bit_reg,
> +	.client_unregister = bit_unreg,
> +	.name = "PCILynx I2C",
>  };

That's not better :)  The structure was much more readable before the
change.  This is especially apparent with large structures.


Cheers,
Jody
