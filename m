Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUEVANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUEVANP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUEVAEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:62689 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264592AbUEUXtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:49:07 -0400
Date: Fri, 21 May 2004 16:48:11 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exporting PCI ROMs via syfs
Message-ID: <20040521234811.GA13404@kroah.com>
References: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 06:05:10PM -0700, Jon Smirl wrote:
> GregKH has suggested that a good interface for accessing the contents of PCI
> ROMs from user space would be to make them available from sysfs. What would be a
> good way to structure the code for doing this? Should this be part of the pci
> driver, and how would this interface into class_simple to make the attribute
> appear?

No class_simple stuff, what about just the sysfs code for the pci device
itself?  Like where we export the config info today?

And yes, it sounds like we need a quirks file to keep some cards from
doing bad things.

thanks,

greg k-h
