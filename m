Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVHZWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVHZWtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVHZWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 18:49:51 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:29035 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVHZWtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 18:49:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WIVQA+fBwkDPhQnlUcVpjLaW2uhAhZm86hEwd/ZxX8ArWPU0V+N4UYKKL50j18T1xE8zadR+VRuYfTIfsv00j+GsrzoY9GIswtsS+BvEE0Sthg1wc6058fPccM88aI7LF8CRyzcKrCRNDKRV6OcHpzov57lubEHFR16OjmMKbLw=
Date: Sat, 27 Aug 2005 02:58:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Message-ID: <20050826225848.GC28191@mipter.zuzino.mipt.ru>
References: <1125094725.18155.120.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125094725.18155.120.camel@betsy>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 06:18:45PM -0400, Robert Love wrote:
> Attached patch provides a driver for the IBM Hard Drive Active
> Protection System (hdaps) on top of 2.6.13-rc6-mm2.

> --- linux-2.6.13-rc6-mm2/drivers/hwmon/hdaps.c
> +++ linux/drivers/hwmon/hdaps.c

> +static int hdaps_probe(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = accelerometer_init();
> +	if (unlikely(ret))

What's the point of having unlikely() attached to every possible if ()?

> +static ssize_t hdaps_temp_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	u8 temp;
> +	int ret;
> +
> +	ret = accelerometer_readb_one(HDAPS_PORT_TEMP, &temp);
> +	if (unlikely(ret < 0))

