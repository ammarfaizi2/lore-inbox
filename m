Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVLJQ4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVLJQ4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 11:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVLJQ4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 11:56:07 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:17412 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932387AbVLJQ4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 11:56:06 -0500
Date: Sat, 10 Dec 2005 17:58:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/2] Add platform_device_del()
Message-Id: <20051210175816.6ce682df.khali@linux-fr.org>
In-Reply-To: <20051210064750.775640000.dtor_core@ameritech.net>
References: <20051210063626.817047000.dtor_core@ameritech.net>
	<20051210064750.775640000.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmirty,

> Driver core: add platform_device_del function
> 
> Having platform_device_del90 allows more straightforward error
> handling code in drivers registering platform devices.
> (...)
> +/**
> + *	platform_device_unregister - unregister a platform-level device
> + *	@pdev:	platform device we're unregistering
> + *
> + *	Unregistration is done in 2 steps. Fisrt we release all resources
> + *	and remove it from the sybsystem, then we drop reference count by

Typo: subsystem.

> + *	calling platform_device_put().
> + */

Other than that, and let alone the fact that I prefer code cleanups as
separate patches, and the fact that I don't think moving
platform_device_register() around adds much value, this patch looks
good to me.

Thanks,
-- 
Jean Delvare
