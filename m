Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTENQQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTENQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:16:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:17336 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262548AbTENQQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:16:50 -0400
Date: Wed, 14 May 2003 09:30:51 -0700
From: Greg KH <greg@kroah.com>
To: "Jon K. Akers" <jka@mbi.ufl.edu>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm5
Message-ID: <20030514163051.GA2250@kroah.com>
References: <CDD2FA891602624BB024E1662BC678ED843F91@mbi-00.mbi.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDD2FA891602624BB024E1662BC678ED843F91@mbi-00.mbi.ufl.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 10:33:43AM -0400, Jon K. Akers wrote:
> I like to at least build the new stuff that comes out with Andrew's
> patches, and building the new gadget code that came out in -mm4 I got
> this when building as a module:
> 
> make -f scripts/Makefile.build obj=drivers/serial
> make -f scripts/Makefile.build obj=drivers/usb/gadget
>   gcc -Wp,-MD,drivers/usb/gadget/.net2280.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include -DMODULE   -DKBUILD_BASENAME=net2280
> -DKBUILD_MODNAME=net2280 -c -o drivers/usb/gadget/net2280.o
> drivers/usb/gadget/net2280.c
> drivers/usb/gadget/net2280.c:2623: pci_ids causes a section type
> conflict

Do you get the same error on the latest -bk patch from Linus's tree?

And what CONFIG_USB_GADGET_* .config options do you have enabled?

thanks,

greg k-h
