Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTEEWIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTEEWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:08:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:58847 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262112AbTEEWI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:08:28 -0400
Date: Mon, 5 May 2003 14:51:41 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB not working with 2.5.69, worked with .68
Message-ID: <20030505215141.GB3111@kroah.com>
References: <1052168060.826.8.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052168060.826.8.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 10:54:20PM +0200, Stian Jordet wrote:
> 
> I have read somewhere that the USB device not accepting new address
> means that the host-controller doesn't get an interrupt, and that this
> often is because of ACPI. It's just the same with acpi disabled (and in
> 2.5.68 it did work with and without acpi).

Hm, can you look at /proc/interrups and verify that the usb controller's
interrupt count is going up?  It really sounds like the interrupt isn't
getting through to the usb controller driver.

thanks,

greg k-h
