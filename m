Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUGGVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUGGVtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUGGVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:49:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:60827 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265502AbUGGVtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:49:04 -0400
Date: Wed, 7 Jul 2004 14:47:31 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creation of driver-specific sysfs attributes
Message-ID: <20040707214731.GA4514@kroah.com>
References: <20040707152106.GB2168@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707152106.GB2168@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:21:06PM -0300, Marcelo Tosatti wrote:
> Hi Greg, others,
> 
> Hope this is not a FAQ.
> 
> I want to export some read-only attributes (statistics) from cyclades.c char 
> driver to userspace via sysfs. 
> 
> I can't figure out the right place to do it - I could create a class under
> /sys/class/cyclades for example, but that doesnt sound right since this 
> is not a "class" of device, but a device itself.

For a driver only attribute, you want them to show up in the place for
the driver (like under /sys/bus/pci/driver/MY_FOO_DRIVER/).  To do that
use the DRIVER_ATTR() and the driver_add_file() functions.  For
examples, see the other drivers that use these functions.

Hope this helps,

greg k-h
