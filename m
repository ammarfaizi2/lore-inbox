Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJVSNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJVSNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJVSNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:13:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:50571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266749AbUJVSMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:12:15 -0400
Date: Fri, 22 Oct 2004 11:08:08 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.6.9-mm1: usb/serial/console.c compile error
Message-ID: <20041022180808.GC2311@kroah.com>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022134305.GB2831@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022134305.GB2831@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:43:05PM +0200, Adrian Bunk wrote:
> 
> The following compile error seems to come from Linus' tree:
> 
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/usb/serial/bus.o
>   CC      drivers/usb/serial/console.o
> drivers/usb/serial/console.c: In function `usb_console_write':
> drivers/usb/serial/console.c:221: warning: passing arg 3 of pointer to function makes integer from pointer without a cast
> drivers/usb/serial/console.c:221: error: too many arguments to function
> drivers/usb/serial/console.c:223: warning: passing arg 3 of `usb_serial_generic_write' makes integer from pointer without a cast
> drivers/usb/serial/console.c:223: error: too many arguments to function `usb_serial_generic_write'
> make[3]: *** [drivers/usb/serial/console.o] Error 1
> 
> <--  snip  -->
> 
> 
> This was caused by the changed "write" in usb_serial_device_type.
> 
> 
> Is the following patch correct?

Yes it is, thanks.  I've applied it.

greg k-h
