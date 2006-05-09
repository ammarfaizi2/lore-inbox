Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWEIWBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWEIWBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEIWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:01:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:24654 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWEIWBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:01:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=V1UmXC9ibO2rie0kaeBFyBuwZUDAw560ymP6Z4yEXQMe3zqsvxSITu6EydT2nRg7PUyhgbCBpOmXbQY85E9eicoqbrJ3wFoJ8/LJBUxBMuw7ek7GO9wncOz2aCNcoXdXQGEXECOBMOU2oWXKok0/WLcl0du4vkbN17VUTeqtPKg=
Date: Wed, 10 May 2006 01:59:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Allen <amah@highpoint-tech.com>
Cc: linux-scsi@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Message-ID: <20060509215936.GD7237@mipter.zuzino.mipt.ru>
References: <200605092128.k49LSQ6R024308@mail.hypersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605092128.k49LSQ6R024308@mail.hypersurf.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:28:31PM -0700, Allen wrote:
> This is the first time driver submission of HighPoint RocketRAID 3xxx
> controllers.

Please, use sane mailer. Sane means:
* it shouldn't convert tab to space
* it shouldn't wrap long lines

> +static struct class_device_attribute hptiop_attr_ioctl = {
> + .attr = {
> +  .name = "ioctl",
> +  .mode = S_IWUSR,
> + },
> + .store = hptiop_store_ioctl
> +};

No way in hell. ioctls are done by defining ->ioctl method.
struct scsi_host_template has one. struct file_operations has one.
Quick grepping shows some subsystems also exctracted ->ioctl.

That plethora of HPT_IOCTL_* defines, where are you using them? What
arguments are passed in and out?

s/vender/vendor/ somewhere, also

