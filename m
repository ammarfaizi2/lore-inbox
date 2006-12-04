Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966308AbWLDT7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966308AbWLDT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966280AbWLDT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:59:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:41671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965885AbWLDT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:59:14 -0500
Date: Mon, 4 Dec 2006 11:58:59 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a device to a new parent.
Message-ID: <20061204195859.GB29637@kroah.com>
References: <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com> <11650154282911-git-send-email-greg@kroah.com> <11650154311175-git-send-email-greg@kroah.com> <1165163163.19590.62.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165163163.19590.62.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 05:26:03PM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> > Provide a function device_move() to move a device to a new parent device. Add
> > auxilliary functions kobject_move() and sysfs_move_dir().
> > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> > interface kobject_uevent_env() is created that allows to add further
> > environmental data to the uevent at the kobject layer.
> 
> has this one been tested? I don't get it working. I always get an EINVAL
> when trying to move the TTY device of a Bluetooth RFCOMM link around.

I relied on Cornelia to test this.  I think some s390 patches depend on
this change, right?

> And shouldn't device_move(dev, NULL) re-attach it to the virtual device
> tree instead of failing?

Yes, that would be good to have.

thanks,

greg k-h
