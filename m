Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVJLWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVJLWtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJLWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:49:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:14740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932486AbVJLWtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:49:50 -0400
Date: Wed, 12 Oct 2005 15:49:19 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051012224919.GA1730@kroah.com>
References: <200510060803.21470.mgross@linux.intel.com> <200510061554.35039.mgross@linux.intel.com> <20051006231501.GB7488@kroah.com> <200510121530.00997.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121530.00997.mgross@linux.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 03:30:00PM -0700, Mark Gross wrote:
> 
> Most significantly I moved the driver from a misc_device to a
> platform_device.

You should still use the misc_device to register your file ops, just
stick with the platform device for the sysfs stuff.  You need that
misc_device in order to work properly with udev.  Have you tested this
code on a udev-only system?

Other than that, it looks very good.

Oh, one minor thing:

> +#include <linux/sysfs.h>
> +#define DEBUG
> +#include <linux/device.h>

Do you always want DEBUG to be enabled?  :)

thanks,

greg k-h
