Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263347AbVCMH37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbVCMH37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCMH37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 02:29:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:26504 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263398AbVCMH3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 02:29:20 -0500
Date: Sat, 12 Mar 2005 23:28:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.11.3
Message-ID: <20050313072813.GA20358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As there were no complaints about the patches posted a few days ago,
I've released 2.6.11.3 with them in it.

It's available now in the normal kernel.org places:
	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.3.gz
which is a patch against the 2.6.11 release (note, this is different
than before, and should fix all of the previous complaints.)

I've also rediffed the 2.6.11.2 patch against the 2.6.11 release,
instead of the 2.6.11.1 release, and updated it.  There are incremental
patches between the 2.6.11.y releases at:
	kernel.org/pub/linux/kernel/v2.6/incr

If anyone has any issues with the way the patches are diffed, please let
me know.

A detailed changelog can be found at:
 	kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.11.3

A bitkeeper tree for the 2.6.11.y releases can be found at:
	bk://linux-release.bkbits.net/linux-2.6.11

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.2 and 2.6.11.3, as it is small enough to do so.

thanks,
 
greg k-h

-------

 Makefile                               |    2 +-
 arch/ppc/oprofile/op_model_fsl_booke.c |    3 +--
 arch/ppc/platforms/4xx/ebony.h         |    4 ++--
 arch/ppc/platforms/4xx/luan.h          |    6 +++---
 arch/ppc/platforms/4xx/ocotea.h        |    4 ++--
 drivers/char/drm/drm_ioctl.c           |    2 ++
 drivers/media/video/adv7170.c          |    2 +-
 drivers/media/video/adv7175.c          |    2 +-
 drivers/media/video/bt819.c            |    2 +-
 drivers/media/video/saa7110.c          |   33 ++++++++++++++++-----------------
 drivers/media/video/saa7114.c          |    2 +-
 drivers/media/video/saa7185.c          |    2 +-
 drivers/net/r8169.c                    |   17 ++++++++++-------
 drivers/net/sis900.c                   |   30 ++++++++++++++----------------
 drivers/net/via-rhine.c                |    3 +++
 drivers/pci/hotplug/pciehp_ctrl.c      |    3 ++-
 fs/cramfs/inode.c                      |    1 +
 net/ipv4/tcp_timer.c                   |    1 +
 18 files changed, 63 insertions(+), 56 deletions(-)


Summary of changes from v2.6.11.2 to v2.6.11.3
==============================================

Alexander Nyberg:
  o PCI: fix hotplug double free

David S. Miller:
  o [TCP]: Put back tcp_timer_bug_msg[] symbol export

Egbert Eich:
  o drm missing memset can crash X server

Eric Lammerts:
  o cramfs: small stat(2) fix

Greg Kroah-Hartman:
  o Linux 2.6.11.3

Herbert Xu:
  o sis900 kernel oops fix

Jean Delvare:
  o fix amd64 2.6.11 oops on modprobe (saa7110)
  o Fix i2c messsage flags in video drivers

Kumar Gala:
  o ppc32: trivial fix for e500 oprofile build

Matt Porter:
  o ppc32: Compilation fixes for Ebony, Luan and Ocotea

Olof Johansson:
  o [VIA RHINE] older chips oops on shutdown

Stephen Hemminger:
  o r8169: receive descriptor length fix

