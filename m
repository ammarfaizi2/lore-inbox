Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTLSTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTLSTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:06:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:7362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263593AbTLSTGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:06:21 -0500
Date: Fri, 19 Dec 2003 10:10:39 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Message-ID: <20031219181039.GI3017@kroah.com>
References: <20031218091404.4b2f743b.akpm@osdl.org> <20031219031034.B28F62C0FA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219031034.B28F62C0FA@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 11:03:57AM +1100, Rusty Russell wrote:
> > Similar considerations apply to scanner:
> > alias char-major-180-48 scanner
> 
> Where did this alias come from?  Of course, scanner.c could put in
> such an alias, but is it really constant?  If so, by all means add a
> MODULE_ALIAS_CHARDEV() line in scanner.c.  Otherwise, leave it to the
> hotplug code.

Please just leave it up to the hotplug code to load such drivers as
these.  Also watch out, if you enable CONFIG_USB_DYNAMIC_MINORS then the
usb scanner driver will NOT start at minor number 48, but will be
dynamically created.

thanks,

greg k-h
