Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTEMUCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEMUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:02:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44263 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261874AbTEMUCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:02:02 -0400
Date: Tue, 13 May 2003 13:09:53 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk7: multiple definition of `usb_gadget_get_string'
Message-ID: <20030513200953.GC11540@kroah.com>
References: <20030512205848.GU1107@fs.tum.de> <20030512211159.GA29716@kroah.com> <3EC03705.8040100@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC03705.8040100@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 05:06:29PM -0700, David Brownell wrote:
> Greg KH wrote:
> >On Mon, May 12, 2003 at 10:58:48PM +0200, Adrian Bunk wrote:
> >>`usb_gadget_get_string':
> >>: multiple definition of `usb_gadget_get_string'
> >>drivers/usb/gadget/g_zero.o(.text+0x0): first defined here
> >>make[2]: *** [drivers/usb/gadget/built-in.o] Error 1
> >
> >
> >I don't think that g_zero and g_ether are allowed to be built into the
> >kernel at the same time.  David, want to send a patch to fix the Kconfig
> >file to prevent this?
> 
> Yes, just one: there's only one upstream USB connector,
> it can only have one driver.  Patch attached.
> 
> Seems like the xconfig/menuconfig coredumps I previously
> saw with tristate choice/endchoice are now gone ... or at
> least they don't show up with this many choices!

Applied, thanks.

greg k-h
