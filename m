Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVCXIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVCXIdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVCXIcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:32:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:16028 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263075AbVCXIcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:32:22 -0500
Date: Thu, 24 Mar 2005 00:03:08 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.11.5][BUILD] i2c.h breakage in 2.6.12-rc1 + -mm only
Message-ID: <20050324080307.GA13886@kroah.com>
References: <11099685952869@kroah.com> <200503240139.29897.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240139.29897.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 01:39:29AM -0500, Shawn Starr wrote:
> include/linux/i2c.h:58: error: array type has incomplete element type
> include/linux/i2c.h:197: error: array type has incomplete element type
> /usr/local/src/sources/r300_driver/drm/linux-core/radeon_drv.h:274: confused by earlier errors, bailing out

Woah, that's you trying to build an out-of-the-kernel-tree driver?
Seems like it needs to be fixed up :)

> I see further back you fed the gcc 4.0 compile fixes to akpm for this,
> can this be merged in to 2.6.11.6?

Why?  It's not needed for 2.6.11.  Builds with compiler versions that
are not even yet released are not -stable acceptable patches, sorry.

thanks,

greg k-h
