Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUCAUUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUCAUUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:20:35 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:32438 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261425AbUCAUUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:20:30 -0500
Message-ID: <40439B03.4000505@backtobasicsmgmt.com>
Date: Mon, 01 Mar 2004 13:20:19 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Kukard <nkukard@lbsd.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
References: <4043938C.9090504@lbsd.net>
In-Reply-To: <4043938C.9090504@lbsd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard wrote:

> --- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
> +++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
> @@ -605,7 +605,7 @@
> 
>  static struct miscdevice tun_miscdev = {
>         .minor = TUN_MINOR,
> -       .name = "net/tun",
> +       .name = "tun",
>         .fops = &tun_fops
>  };

This changed back and forth since the tun driver was added to the 
kernel; making this change will cause the devfs path to the tun node to 
change, and userspace applications expect it to be at /dev/misc/net/tun, 
whether that's right or wrong.
