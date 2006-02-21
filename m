Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWBUSeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWBUSeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWBUSeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:34:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:49893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932517AbWBUSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:34:14 -0500
Date: Tue, 21 Feb 2006 09:49:50 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [PATCH 0/4] Fix runtime device suspend/resumre interface
Message-ID: <20060221174950.GA23054@kroah.com>
References: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:55:34PM -0800, Patrick Mochel wrote:
> 
> Hi there,
> 
> Here is an updated version of the patches to fix the sysfs interface for
> runtime device power management by restoring the file to its originally
> designed behavior - to place devices in the power state specified by the
> user process writing to the file.
> 
> Recently, the interface was changed to filter out values to prevent a
> BUG() that was introduced in the PCI power management code. While a valid
> fix, it makes the driver core filter values that might otherwise be used
> by the bus/device drivers.

Are there any existing bus/device drivers that are currently broken
because of this change?

thanks,

greg k-h
