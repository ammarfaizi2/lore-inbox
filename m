Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVCIAJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVCIAJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVCIAE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:04:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:62097 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262414AbVCIACK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:02:10 -0500
Date: Tue, 8 Mar 2005 15:58:07 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050308235807.GA11807@kroah.com>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422DF525.8030606@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:55:33PM -0500, Wen Xiong wrote:
> +static ssize_t jsm_driver_boards_show(struct device_driver *ddp, char *buf)
> +{
> +	int adapter_count = 0;
> +	adapter_count = jsm_total_boardnum();
> +	return snprintf(buf, PAGE_SIZE, "%d\n", adapter_count);
> +}
> +static DRIVER_ATTR(boards, S_IRUSR, jsm_driver_boards_show, NULL);

Why is this file even needed?  You can just look at the number of sysfs
directories attached to this device, right?

thanks,

greg k-h
