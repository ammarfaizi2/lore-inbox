Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWBAElH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWBAElH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWBAElH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:41:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964914AbWBAElG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:41:06 -0500
Date: Tue, 31 Jan 2006 20:40:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060131204045.67b57e17.akpm@osdl.org>
In-Reply-To: <20060201043824.GF23039@kurtwerks.com>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060201043824.GF23039@kurtwerks.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall <kwall@kurtwerks.com> wrote:
>
> On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton took 397 lines to write:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> 
> depmod loop:
> 
> $ sudo make modules_install:
> ...
>   INSTALL sound/soundcore.ko
>   if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
>   System.map  2.6.16-rc1-mm4krw-1; fi
>   WARNING: Loop detected:
>   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko needs
>   serial_core.ko which needs 8250.ko again!
>   WARNING: Module
>   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko
>   ignored, due to loop
>   WARNING: Module
>   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/serial_core.ko
>   ignored, due to loop
>   WARNING: Module
>   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250_pci.ko
>   ignored, due to loop
>   [~/kernel/linux-2.6.16-rc1-mm4]$
> 

ah.  .config, please?

> The Arkansas legislature passed a law that states that the Arkansas
> River can rise no higher than to the Main Street bridge in Little
> Rock.

Easy: a pontoon bridge.
