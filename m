Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTJQGCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 02:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTJQGCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 02:02:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:17043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263311AbTJQGCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 02:02:46 -0400
Date: Thu, 16 Oct 2003 22:56:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 003 release
Message-ID: <20031017055652.GA7712@kroah.com>
Reply-To: linux-hotplug-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've released the 003 version of udev.  It can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-003.tar.gz

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.6 kernel to run properly.

There have been a number of major changes since the last release:
	- works properly with the current 2.6 kernel (older versions of
	  udev will not work with the current 2.6 kernel.)
	- persistent database support has been added, but not fully
	  integrated (tdb is database code, very nice stuff.)
	- lots of documentation has been added.
	- spec file has been added for building rpms.
	- install and uninstall support added to Makefile to make it
	  easier to install and test with.
	- hard coded config file paths have been fixed.
	- callout support has been added (allows other programs to be
	  run to determine what to name a device.)
	- cross compile bugs fixed.
	- TODO list expanded for those who wish to help out.
	- lots of other stuff fixed.

The full ChangeLog is below.

The new udev FAQ is included in this release, and can also be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug/udev-FAQ

Development of udev is done in a BitKeeper tree available at:
	bk://kernel.bkbits.net/gregkh/udev/

If anyone ever wants a snapshot of the current tree, due to not using
BitKeeper, or other reasons, is always available at any time by asking.

thanks,

greg k-h


Summary of changes from v0.2 to v003
============================================

Daniel E. F. Stekloff:
  o udevdb patch
  o udevdb prototype

Greg Kroah-Hartman:
  o update changelog for 003 release TAG: v003
  o update the spec file for the new version and install process
  o fix makefile release rule to not drop tdb.h file
  o Add FAQ for udev
  o removed AUTHORS and INSTALL files as they were pretty pointless
  o copyright updates
  o Add AUTHORS and INSTALL files
  o TODO updates
  o Updatd the README
  o updated the TODO list
  o add udev man page (basically just a place holder for now.)
  o added uninstall support
  o added install target for makefile so people don't have to do it by hand anymore
  o add version to debug log on startup
  o tell the user what mknod() we are trying to do
  o add dbg_parse() to cut down on parse file debugging statements
  o put config files and database in /etc/udev by default
  o add ols 2003 udev paper to docs/
  o clean up some debugging stuff in namedev.c
  o do not build the tdb binary programs, only the objects
  o merge tdb into the build process
  o Added tdb code from latest cvs version in the samba tree
  o added my name to the .spec file
  o minor cleanups
  o cleanup the mknod code a bit
  o remove mknod callout
  o handle new major:minor format of dev files that showed up in 2.6.0-test2-bk3 or so
  o oops, everything was getting created as 000 mode, try to fix this up, but fail...
  o more test stuff

Olaf Hering:
  o print udev pid

Patrick Mansfield:
  o add callout config type to udev

Paul Mundt:
  o Fix TDB cross compilation
  o udev spec file
  o udev/libsysfs cross compile fixes

