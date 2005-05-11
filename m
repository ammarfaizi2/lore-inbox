Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVEKRKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVEKRKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVEKRKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:10:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:47320 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261997AbVEKRKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:10:18 -0400
Date: Wed, 11 May 2005 10:06:00 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org,
       Justin Thiessen <jthiessen@penguincomputing.com>
Subject: Re: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-ID: <20050511170600.GD15398@kroah.com>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2538186705051100583c6b1ffb@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> Hi,
> 
> This patch presents as an example one possible way to use the dynamic
> callbacks to clean up one of the i2c chip drivers, adm1026 (for more
> information please see
> http://archives.andrew.net.au/lm-sensors/msg31310.html).
> 
> The first patch defines a new macros like DEVICE_ATTR that also sets
> the attribute private data (Greg whats your opinion on defining a
> separate set of macros for this v.s. rolling it into one macro?).

We should make a __ATTR macro instead, right?

> The second patch changes adm1026 to pass the sensor index/number via
> the private data pointer. I can't test this patch (so you won't want
> to apply this) but I'm CCing it to the adm1026 maintainer.

One patch per email please...

thanks,

greg k-h
