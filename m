Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271698AbTGRCXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271697AbTGRCVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:21:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:6073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271695AbTGRCV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:21:26 -0400
Date: Thu, 17 Jul 2003 19:35:52 -0700
From: Greg KH <greg@kroah.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI vendor and device strings in sysfs
Message-ID: <20030718023552.GA5926@kroah.com>
References: <20030717101123.GA6069@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717101123.GA6069@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 03:41:24PM +0530, Ananth N Mavinakayanahalli wrote:
> Hi,
> 
> Here is a patch against 2.6.0-test1 to display PCI vendor and
> device strings in sysfs.
> 
> At present, the PCI "name" attribute has a length restriction
> (DEVICE_NAME_SIZE) within which it tries to accomodate the vendor
> and device strings, leading to, in most cases, truncation of one
> or both strings.
> 
> This patch alleviates the issue by creating the vendor_name and
> device_name attributes for PCI devices.

I agree with Pat, this should be done in userspace.

We should really just get rid of the dev->name file all together to keep
people from relying on it :)

thanks,

greg k-h
