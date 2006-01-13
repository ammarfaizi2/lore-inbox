Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWAMLwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWAMLwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWAMLwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:52:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161225AbWAMLws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:52:48 -0500
Date: Fri, 13 Jan 2006 03:52:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.15-mm3
Message-Id: <20060113035229.0560a5dd.akpm@osdl.org>
In-Reply-To: <43C76623.7060906@in.ibm.com>
References: <20060111042135.24faf878.akpm@osdl.org>
	<43C76623.7060906@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sachin Sant <sachinp@in.ibm.com> wrote:
>

Please always do reply-to-all.

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
> 
> I got this compile time error on a powerpc box.
> 

yup, thanks.

> ...
>    CC [M]  drivers/usb/input/mtouchusb.o
>    CC [M]  drivers/usb/input/powermate.o
>    CC [M]  drivers/usb/input/wacom.o
> drivers/usb/input/wacom.c:98: error: conflicting types for `G4'
> include/asm/cputable.h:37: error: previous declaration of `G4'
> make[3]: *** [drivers/usb/input/wacom.o] Error 1
> make[2]: *** [drivers/usb/input] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> Problem seems to be because of the following in 
> include/asm-powerpc/cputable.h
> 
> enum powerpc_oprofile_type {
>          INVALID = 0,
>          RS64 = 1,
>          POWER4 = 2,
>          G4 = 3,     <====Defined here
>          BOOKE = 4,
> };
> 

err, Ben.  Not a great choice of identifier...
