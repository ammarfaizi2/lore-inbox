Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbULVA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbULVA2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbULVA2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:28:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:53669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261919AbULVA2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:28:21 -0500
Date: Tue, 21 Dec 2004 16:28:10 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow struct bin_attributes in class devices
Message-ID: <20041222002810.GA12886@kroah.com>
References: <200412211619.52596.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211619.52596.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 04:19:52PM -0800, Jesse Barnes wrote:
> This small patch adds routines to create and remove bin_attribute files for 
> class devices.  One intended use is for binary files corresponding to PCI 
> busses, like bus legacy I/O ports or ISA memory.
> 
>  drivers/base/class.c   |   16 ++++++++++++++++
>  include/linux/device.h |    5 ++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Ugh, we'll get this eventually... You forgot a EXPORT_SYMBOL_GPL() so
that modules can use these functions :)

Third time's a charm :)

thanks,

greg k-h
