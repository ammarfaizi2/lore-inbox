Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUI3A1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUI3A1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUI3A1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:27:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:3560 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269218AbUI3AVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:21:16 -0400
Date: Wed, 29 Sep 2004 17:21:01 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] [take 2] USB: use add_hotplug_env_var in core/usb.c
Message-ID: <20040930002100.GA27439@kroah.com>
References: <200409281919.aKAVlO4yKkPzE7f0@topspin.com> <200409281919.8RXPZodVBIYTqtXg@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409281919.8RXPZodVBIYTqtXg@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 07:19:34PM -0700, Roland Dreier wrote:
> Use the new add_hotplug_env_var() function in drivers/usb/core/usb.c.
> In addition to cleaning up the code, this fixes a (probably harmless)
> bug here: for each value added to the environment, the code did
> 
> 	length += sprintf(...);
> 
> and then
> 
> 	scratch += length;
> 
> which means that we skip the sum of the lengths of all the values
> we've put so far, rather than just the length of the value we just
> put.  This is probably harmless since we're unlikely to run out of
> space but if nothing else it's setting a bad example....
> 
> I've tested this on a system with USB floppy and CD-ROM; hotplug gets
> the same environment with the patch as without.

Applied, thanks.

greg k-h
