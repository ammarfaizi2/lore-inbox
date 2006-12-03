Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756677AbWLCQZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbWLCQZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756498AbWLCQZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:25:59 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:32708 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1756677AbWLCQZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:25:57 -0500
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a
	device to a new parent.
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <11650154311175-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com>
	 <11650153262399-git-send-email-greg@kroah.com>
	 <11650153293531-git-send-email-greg@kroah.com>
	 <1165015333344-git-send-email-greg@kroah.com>
	 <11650153362310-git-send-email-greg@kroah.com>
	 <11650153392022-git-send-email-greg@kroah.com>
	 <11650153432284-git-send-email-greg@kroah.com>
	 <11650153463092-git-send-email-greg@kroah.com>
	 <1165015349830-git-send-email-greg@kroah.com>
	 <11650153522862-git-send-email-greg@kroah.com>
	 <116501535622-git-send-email-greg@kroah.com>
	 <11650153591876-git-send-email-greg@kroah.com>
	 <11650153631070-git-send-email-greg@kroah.com>
	 <1165015366759-git-send-email-greg@kroah.com>
	 <11650153704007-git-send-email-greg@kroah.com>
	 <11650153733277-git-send-email-greg@kroah.com>
	 <11650153763330-git-send-email-greg@kroah.com>
	 <11650153792132-git-send-email-greg@kroah.com>
	 <11650153833896-git-send-email-greg@kroah.com>
	 <11650153861854-git-send-email-greg@kroah.com>
	 <11650153891878-git-send-email-greg@kroah.com>
	 <11650153 922117-git-send-email-greg@kroah.com>
	 <11650153961479-git-send-email-greg@kroah.com>
	 <11650154001320-git-send-email-greg@kroah.com>
	 <11650154032080-git-send-email-greg@kroah.com>
	 <11650154071138-git-send-email-greg@kroah.com>
	 <11650154123942-git-send-email-greg@kroah.com>
	 <1165015415131-git-send-email-greg@kroah.com>
	 <11650154181661-git-send-email-greg@kroah.com>
	 <11650154221716-git-send-email-greg@kroah.com>
	 <11650154251022-git-send-email-greg@kroah.com>
	 <11650154282911-git-send-email-greg@kroah.com>
	 <11650154311175-git-send-email-greg@kroah.com>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 17:26:03 +0100
Message-Id: <1165163163.19590.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Provide a function device_move() to move a device to a new parent device. Add
> auxilliary functions kobject_move() and sysfs_move_dir().
> kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> interface kobject_uevent_env() is created that allows to add further
> environmental data to the uevent at the kobject layer.

has this one been tested? I don't get it working. I always get an EINVAL
when trying to move the TTY device of a Bluetooth RFCOMM link around.

And shouldn't device_move(dev, NULL) re-attach it to the virtual device
tree instead of failing?

Regards

Marcel


