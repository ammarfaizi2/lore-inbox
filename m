Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSL3WFq>; Mon, 30 Dec 2002 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSL3WFp>; Mon, 30 Dec 2002 17:05:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47887 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265885AbSL3WFo>;
	Mon, 30 Dec 2002 17:05:44 -0500
Date: Mon, 30 Dec 2002 14:09:12 -0800
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proposed PnP layer changes/fixes and cleanups
Message-ID: <20021230220911.GD32324@kroah.com>
References: <Pine.LNX.4.33.0212201557270.824-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212201557270.824-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 12:20:15PM +0100, Jaroslav Kysela wrote:
> Hi,
> 
> 	I've revised the PnP code and found numerous of simple bugs. Also,
> my opinion is that the resctriction of resources to only ones hardcoded by
> hardware vendors is not a good idea. Hardware usually supports more
> configurations (especially ISA PnP devices).
> 	I've tried to implement a configuration template, so driver can
> pass it's own resource map in the probe phase. Also, I've added a new
> member to the driver structures - flags. The flag
> PNP_DRIVER_DO_NOT_ACTIVATE instructs the pnp code that the device
> shouldn't be activated before the probe() callback is entered. It's
> necessary to implement this behaviour to allow passing of a new
> configuration template (thus calling pnp_activate_dev() from the probe()
> callback).
> 	Also, the resources can be locked now (I've changed the ro flag to 
> lock_resources).

These changes look good, I'll send them on to Linus.

thanks,

greg k-h
