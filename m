Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUI2X3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUI2X3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUI2X27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:28:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:5838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269168AbUI2X2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:28:04 -0400
Date: Wed, 29 Sep 2004 16:20:37 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle usb host allocation failures
Message-ID: <20040929232037.GC26548@kroah.com>
References: <200409271517.32192.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409271517.32192.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 03:17:32PM -0700, Jesse Barnes wrote:
> It looks like a host (like ohci or whatever) could try to allocate a new 
> usb_device structure with usb_alloc_dev and get back a valid pointer even if 
> the allocation of its private data failed.  I first saw this in the 2.4 
> sources, but it looks like 2.6 has the same problem.  This patch attempts to 
> fix it by freeing dev if the ->allocate() routine fails, and then returns 
> NULL instead of a potentially dangerous dev pointer.
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Applied, thanks.

greg k-h
