Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUDORmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDORlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:41:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:34740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263028AbUDORiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:38:09 -0400
Date: Thu, 15 Apr 2004 10:35:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core update for 2.6.6-rc1
Message-ID: <20040415173521.GA4117@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few driver core changes for 2.6.6-rc1.  These have all been
in the -mm tree for a number of weeks now.  They fix a few minor bugs,
and add sysfs class support to a few miscellaneous drivers.

I'd like to thank Andrew for fixing the vc bug so that the sysfs class
patch that I've been sitting on for months can be added to the main
tree, that was pretty nasty...

Please pull from:
	bk://linuxusb.bkbits.net/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/Kconfig                    |   16 ++++-----
 drivers/base/class.c                    |    6 +--
 drivers/char/dsp56k.c                   |   27 +++++++++++++++-
 drivers/char/ftape/zftape/zftape-init.c |   17 ++++++++++
 drivers/char/istallion.c                |   24 ++++++++++++--
 drivers/char/stallion.c                 |   12 ++++++-
 drivers/char/tipar.c                    |   16 ++++++---
 drivers/char/tpqic02.c                  |   44 ++++++++++++++++++++++++++
 drivers/char/vc_screen.c                |   10 ++++++
 drivers/char/vt.c                       |    6 ++-
 drivers/isdn/capi/capi.c                |   53 +++++++++++++++++++++-----------
 drivers/video/fbmem.c                   |   38 ++++++++++++++++++++++
 fs/coda/psdev.c                         |   38 +++++++++++++++++++---
 lib/kobject.c                           |    6 +--
 14 files changed, 261 insertions(+), 52 deletions(-)
-----


<lxiep:ltcfwd.linux.ibm.com>:
  o kobject_set_name() doesn't allocate enough space

<romain:lievin.net>:
  o tipar char driver (divide by zero)

Greg Kroah-Hartman:
  o Driver class: remove possible oops
  o VC: fix bug in vty_init() where vcs_init() was not called early enough
  o add sysfs support for vc devices
  o Driver Core: fix spaces instead of tabs problem in the Kconfig file

Hanna V. Linder:
  o Fix class support to istallion.c
  o Fix for patch to add class support to stallion.c
  o fix sysfs class support to fs/coda/psdev.c
  o Add sysfs class support to fs/coda/psdev.c
  o add class support to dsp56k.c
  o added class support to istallion.c
  o added class support to stallion.c
  o add class support to floppy tape driver zftape-init.c
  o QIC-02 tape drive hookup to classes in sysfs

Luca Tettamanti:
  o Sysfs for framebuffer

Marcel Holtmann:
  o Fix sysfs class support for CAPI
  o Add sysfs class support for CAPI

