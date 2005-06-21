Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVFUI0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVFUI0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVFUITk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:19:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26382 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261996AbVFUHnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:43:07 -0400
Date: Tue, 21 Jun 2005 08:43:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: recursive call to platform_device_register deadlocks
Message-ID: <20050621084301.B30570@flint.arm.linux.org.uk>
Mail-Followup-To: Jamey Hicks <jamey.hicks@hp.com>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <42B43226.20703@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B43226.20703@hp.com>; from jamey.hicks@hp.com on Sat, Jun 18, 2005 at 10:39:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 10:39:34AM -0400, Jamey Hicks wrote:
> We've started working on replacing uses of soc_device in handhelds 
> drivers by platform_device.   One of the things we ran into is that the 
> platform_device driver for an ASIC was calling soc_device_register 
> inside its probe function.  If this is converted to 
> platform_device_register, then the process deadlocks because 
> bus_add_device locks platform_bus_type.

This should now be resolved as a result of Greg's recent patch driver
model patch set, as appeared on lkml last night.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
