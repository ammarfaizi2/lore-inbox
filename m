Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVAaS1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVAaS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVAaS1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:27:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:60359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261302AbVAaS0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:26:25 -0500
Date: Mon, 31 Jan 2005 10:25:42 -0800
From: Greg KH <greg@kroah.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: phil@netroedge.com, sensors@stimpy.netroedge.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-ID: <20050131182542.GB21438@kroah.com>
References: <41F6F1D5.90601@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6F1D5.90601@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 06:26:45PM -0700, Mark A. Greer wrote:
> +static inline void
> +mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)

This is a much too big of a function to be "inline".  Please change it.
Same for your other inline functions, that's not really needed, right?

> +{
> +	pr_debug("mv64xxx_i2c_fsm: ENTER--state: %d, status: 0x%x\n",
> +		drv_data->state, status);

Please use the dev_* calls instead.  It gives you an accurate
description of the specific device that emits the messages.  Also use it
for all of the printk() calls in the driver too.

thanks,

greg k-h
