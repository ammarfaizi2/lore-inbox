Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVAHWm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVAHWm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVAHWm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:42:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:25546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261203AbVAHWml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:42:41 -0500
Date: Sat, 8 Jan 2005 14:42:32 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
Message-ID: <20050108224232.GA3588@kroah.com>
References: <11051632633234@kroah.com> <11051632632994@kroah.com> <20050108120858.GB27414@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108120858.GB27414@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:08:58PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 07, 2005 at 09:47:43PM -0800, Greg KH wrote:
> > ChangeSet 1.1938.444.33, 2004/12/22 13:50:21-08:00, davej@redhat.com
> > 
> > [PATCH] driver core: Fix up vesafb failure probing.
> > 
> > bus.c file invokes a probe callback for most devices in a list, then checks
> > for -ENODEV return ("no such device"), if so it remains silent. However, some
> > drivers (including vesafb.c) may return -ENXIO ("no such device or address"),
> > which is indeed error -6.
> > 
> > I shut up the warning with the attached patch, that basically ignores
> > both -ENODEV and -ENXIO.
> 
> NAK.  We shouldn't have two return codes indicating the same error (or
> actually non-error in this case).  Let's fix the drivers instead.

Ok, David, care to send a patch to do so?

thanks,

greg k-h
