Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTELU6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTELU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:58:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46790 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262715AbTELU6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:58:53 -0400
Date: Mon, 12 May 2003 14:11:59 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk7: multiple definition of `usb_gadget_get_string'
Message-ID: <20030512211159.GA29716@kroah.com>
References: <20030512205848.GU1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512205848.GU1107@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:58:48PM +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>    ld -m elf_i386  -r -o drivers/usb/gadget/built-in.o 
> drivers/usb/gadget/net2280.o drivers/usb/gadget/g_zero.o 
> drivers/usb/gadget/g_ether.o
> drivers/usb/gadget/g_ether.o(.text+0x1f60): In function 
> `usb_gadget_get_string':
> : multiple definition of `usb_gadget_get_string'
> drivers/usb/gadget/g_zero.o(.text+0x0): first defined here
> make[2]: *** [drivers/usb/gadget/built-in.o] Error 1

I don't think that g_zero and g_ether are allowed to be built into the
kernel at the same time.  David, want to send a patch to fix the Kconfig
file to prevent this?

thanks,

greg k-h
