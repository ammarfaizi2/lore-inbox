Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbTGaUXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 16:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTGaUXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 16:23:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:51856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268228AbTGaUXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 16:23:16 -0400
Date: Thu, 31 Jul 2003 13:16:59 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Charles Lepple <clepple@ghz.cc>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reorganize USB submenu's
Message-ID: <20030731201659.GA4385@kroah.com>
References: <20030731101144.32a3f0d7.shemminger@osdl.org> <23979.216.12.38.216.1059672599.squirrel@www.ghz.cc> <20030731125032.785ffba1.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731125032.785ffba1.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 12:50:32PM -0700, Stephen Hemminger wrote:
> 	- USB serial debugging can be enabled if module

It can be enabled _only_ if CONFIG_USB_SERIAL=y.  If CONFIG_USB_SERIAL=m
then the option should not show up, as it becomes a module paramater
option.  The original code was correct.

> -menu "USB HID Boot Protocol drivers"
> -	depends on USB!=n && USB_HID!=y
> -

No, we _really_ want these tucked away where it is hard to find them.
Almost noone should enable these, but if you really want them, you still
can.  Putting them into their own sub-menu was deemed the best for this.

thanks,

greg k-h
