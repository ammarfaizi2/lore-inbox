Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTEOFCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTEOFCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:02:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13039 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263796AbTEOFCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:02:49 -0400
Date: Wed, 14 May 2003 22:06:45 -0700
From: Greg KH <greg@kroah.com>
To: davej@codemonkey.org.uk
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sysfs bits
Message-ID: <20030515050645.GA5875@kroah.com>
References: <200305150331.h4F3V21s000551@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305150331.h4F3V21s000551@deviant.impure.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:31:02AM +0100, davej@codemonkey.org.uk wrote:
> Look sane ?
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/base/cpu.c linux-2.5/drivers/base/cpu.c
> --- bk-linus/drivers/base/cpu.c	2003-04-30 16:02:26.000000000 +0100
> +++ linux-2.5/drivers/base/cpu.c	2003-05-01 03:12:55.000000000 +0100
> @@ -46,7 +46,7 @@ int __init register_cpu(struct cpu *cpu,
>  	snprintf(cpu->sysdev.class_dev.class_id, BUS_ID_SIZE, "cpu%d", num);
>  	retval = class_device_register(&cpu->sysdev.class_dev);
>  	if (retval) {
> -		// FIXME cleanup sys_device_register

Thanks, that was my fault for not fixing this properly the first time.

greg k-h
