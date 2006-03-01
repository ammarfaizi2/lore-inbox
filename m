Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCAVcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCAVcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWCAVcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:32:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13465
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751147AbWCAVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:32:16 -0500
Date: Wed, 1 Mar 2006 13:32:23 -0800
From: Greg KH <greg@kroah.com>
To: Ren?? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060301213223.GA17270@kroah.com>
References: <200603012116.25869.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603012116.25869.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 09:16:25PM +0100, Ren?? Rebe wrote:
> Hi,
> 
> I wonder if:
> 
> drivers/usb/core/devio.c:86
> #define MAX_USBFS_BUFFER_SIZE   16384
> 
> is some random, or outdated limit or if there really is some code path that could
> not handle bigger URBs.
> 
> For performance reasons I would like to use bigger packages for an image
> aquisition device.

Why not just send down 2 urbs with that size then, that would keep the
pipe quite full.

thanks,

greg k-h
