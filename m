Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbTDCAu1>; Wed, 2 Apr 2003 19:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263197AbTDCAu1>; Wed, 2 Apr 2003 19:50:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62130 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263196AbTDCAu0>; Wed, 2 Apr 2003 19:50:26 -0500
Date: Wed, 2 Apr 2003 17:01:13 -0800
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch] add i2c_clientname()
Message-ID: <20030403010112.GA5407@kroah.com>
References: <20030402165116.GA24766@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402165116.GA24766@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 06:51:16PM +0200, Gerd Knorr wrote:
> 
> This patch just adds a #define and a inline function to hide the
> "i2c_client->name" => "i2c_client->dev.name" move introduced by
> the recent i2c updates.  That makes it easier to build i2c drivers
> on both 2.4 and 2.5 kernels.

This is going to be a harder and harder problem as time goes on, and as
the i2c core changes over time.  I would just give up now :)

> +#define I2C_DEVNAME(str)   .dev = { .name = str }

Why this macro?  You don't use it in your driver, right?

thanks,

greg k-h
