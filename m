Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVF2Wl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVF2Wl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVF2Wlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:41:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:38546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262707AbVF2Wkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:40:52 -0400
Date: Wed, 29 Jun 2005 15:40:40 -0700
From: Greg KH <greg@kroah.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050629224040.GB18462@kroah.com>
References: <42C30CBC.5030704@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C30CBC.5030704@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:03:56PM +0200, Eric Valette wrote:
> For years now my /dev has been empty. When upgrading to 2.6.13-rc1 from
> 2.6.12, and updating my kernel config file via "make oldconfig" I got no
> visible warning about CONFIG_DEVFS_FS options being set (or at least did
> no see it).

devfs has been marked OBSOLETE for a year now.  It has also been
documented as going away.  Because of this, you should not have been
supprised at all.

> While I do not want to re-enter the endless devfs versus udev merit
> (allthough I personnaly strongly believe udev is just too slow for
> embedded system boot compared to devfs without devfsd)

What are the speed differences that you see?  I've tested it and on a
slow old laptop, with a lot of devices, udev only takes 2 seconds to
initialize the whole device tree.  If you put it in initramfs, it will
take no additional time, as it will operate on all of the hotplug events
as they happen.  Can't get faster than "nothing" :)

> I think that this potential problem should be clearly mentionned  in
> the release note for 2.6.13

That's probably a good idea.

thanks,

greg k-h
