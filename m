Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLUAaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTLUAaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:30:22 -0500
Received: from dp.samba.org ([66.70.73.150]:395 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261881AbTLUAaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:30:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded? 
In-reply-to: Your message of "Fri, 19 Dec 2003 10:10:39 -0800."
             <20031219181039.GI3017@kroah.com> 
Date: Sat, 20 Dec 2003 14:04:59 +1100
Message-Id: <20031221003020.63E6A2C0B8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031219181039.GI3017@kroah.com> you write:
> Please just leave it up to the hotplug code to load such drivers as
> these.  Also watch out, if you enable CONFIG_USB_DYNAMIC_MINORS then the
> usb scanner driver will NOT start at minor number 48, but will be
> dynamically created.

Thanks Greg, that's what I figured.  Although the hotplug subsystem
could create the device nodes and then have kmod load the actual
drivers on open, I'm not convinced it's worth it for dynamic devices.

It's been argued that kmod should place a request with the hotplug
subsystem, rather than call modprobe, but that's a little too radical
for me just yet.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
