Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUDHWDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDHWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:03:35 -0400
Received: from linux-bt.org ([217.160.111.169]:12234 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262774AbUDHWDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:03:33 -0400
Subject: Re: [PATCH 2.6.5] Add sysfs class support to fs/coda/psdev.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, braam@cs.cmu.edu,
       Greg Kroah-Hartman <greg@kroah.com>, coda@cs.cmu.edu
In-Reply-To: <7970000.1081458781@dyn318071bld.beaverton.ibm.com>
References: <7290000.1081457670@dyn318071bld.beaverton.ibm.com>
	 <7970000.1081458781@dyn318071bld.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1081461739.5880.13.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 00:02:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanna,

> Here is the fixed patch:
> 
> diff -Nrup linux-2.6.5/fs/coda/psdev.c linux-2.6.5p/fs/coda/psdev.c
> --- linux-2.6.5/fs/coda/psdev.c	2004-04-03 19:37:36.000000000 -0800
> +++ linux-2.6.5p/fs/coda/psdev.c	2004-04-08 14:05:51.000000000 -0700
> @@ -37,6 +37,7 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/smp_lock.h>
> +#include <linux/device.h>
>  #include <asm/io.h>
>  #include <asm/system.h>
>  #include <asm/poll.h>
> @@ -61,6 +62,7 @@ unsigned long coda_timeout = 30; /* .. s
>  
> 
>  struct venus_comm coda_comms[MAX_CODADEVS];
> +static struct class_simple coda_psdev_class;

I think coda_psdev_class must be a pointer.

Regards

Marcel


