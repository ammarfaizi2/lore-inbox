Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVC3HZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVC3HZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVC3HZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:25:24 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:53154 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261805AbVC3HYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:24:43 -0500
Date: Tue, 29 Mar 2005 23:24:41 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050330072441.GA27870@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291342.27224.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 01:42:26PM -0500, Dmitry Torokhov wrote:
> Could you please try the patch below - it should fix the issues you are
[snip]
> --- dtor.orig/drivers/input/serio/serio.c
> +++ dtor/drivers/input/serio/serio.c
>  	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
> -		serio_disconnect_port(serio);
>  		/*
>  		 * Driver re-probing can take a while, so better let kseriod

Yep, that fixes it.  I applied your patch to 2.6.12-rc1-mm1 and
suspended and resumed 5 times in a row without any difficulty.  Thanks!

-andy
