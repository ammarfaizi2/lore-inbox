Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUGOAei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUGOAei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUGOAeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:34:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:6272 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266025AbUGOASr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:18:47 -0400
Date: Wed, 14 Jul 2004 17:16:51 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core patches for 2.6.8-rc1
Message-ID: <20040715001651.GA20161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a some driver core and assorted patches for 2.6.8-rc1.
They contain:
	- some driver core fixes.
	- a raw.c fix
	- a root_plug.c fix
	- add a new attribute for block devices.

Most of these have all been in the last few -mm tree releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/Kconfig             |    2 -
 drivers/base/bus.c               |   39 ++++++++++++++++++++-
 drivers/base/core.c              |   10 +++++
 drivers/base/driver.c            |   19 ++++++++++
 drivers/base/platform.c          |   72 +++++++++++++++++++++++++++++++++++++--
 drivers/block/genhd.c            |   11 +++++
 drivers/char/raw.c               |   15 ++++----
 drivers/pci/hotplug/rpaphp_vio.c |    9 ++++
 include/linux/device.h           |    4 ++
 lib/kobject.c                    |    7 ++-
 security/root_plug.c             |    6 +--
 11 files changed, 175 insertions(+), 19 deletions(-)
-----

<mika:osdl.org>:
  o Upgrade security/root_plug.c to new module parameter syntax

Andrew Morton:
  o raw.c cleanups

Dmitry Torokhov:
  o Driver core: Fix OOPS in device_platform_unregister
  o Driver core: add driver_find helper to find a driver by its name
  o Driver core: kset_find_obj should increment refcount of the found object
  o Driver core: add default driver attributes to struct bus_type
  o Driver core: add platform_device_register_simple to register platform

Greg Kroah-Hartman:
  o Driver Core: remove extra space in Kconfig file

Olaf Hering:
  o add removeable sysfs block device attribute

