Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVAUIoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVAUIoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVAUIoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:44:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:6542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262321AbVAUIoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:44:32 -0500
Date: Fri, 21 Jan 2005 00:42:04 -0800
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]
Message-ID: <20050121084204.GA20397@kroah.com>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net> <1106210408.6932.27.camel@localhost.localdomain> <20050121000822.GA14580@kroah.com> <1106293748.783.31.camel@baythorne.infradead.org> <20050121075833.GA19995@kroah.com> <1106295136.783.47.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106295136.783.47.camel@baythorne.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 08:12:16AM +0000, David Woodhouse wrote:
> On Thu, 2005-01-20 at 23:58 -0800, Greg KH wrote:
> > Well, we should be byteswapping all of the fields that need to be
> > swapped, right?  I'm guessing that userspace is expecting the fields
> > to be in cpu endian, correct?
> 
> Userspace varies in that. Nobody expects _all_ the fields to be swapped;
> the kernel only ever swapped those four. And in fact lsusb from the
> stock usbutils expects it to be consistently little-endian. John's
> version seems to be hacked to expect just those four fields to be host-
> endian, while the rest remains little-endian.
> 
> We have a choice here -- we can preserve the ABI by continuing to be
> stupidly inconsistent about endianness, or you can revert my patch and
> stock usbutils can be correct.

Let's preserve the ABI, that's the safest thing to do.

> > But if you want, I'll gladly revert your patch, as I don't have a ppc
> > box to test this out on.
> 
> I'd revert it.

Done.

thanks,

greg k-h
