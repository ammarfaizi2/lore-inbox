Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVL0Ay5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVL0Ay5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVL0Ay5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 19:54:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:17591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932172AbVL0Ay4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 19:54:56 -0500
Date: Mon, 26 Dec 2005 16:53:27 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.5
Message-ID: <20051227005327.GA21786@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.5 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.4 and 2.6.14.5, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                    |    2 -
 drivers/acpi/video.c                        |    2 -
 drivers/scsi/dpt_i2o.c                      |   25 ++++++++++++++++-----
 drivers/scsi/scsi_lib.c                     |   33 +++++++++++++++++-----------
 drivers/scsi/sd.c                           |   16 -------------
 drivers/scsi/sr.c                           |   20 ++--------------
 drivers/scsi/st.c                           |   19 ----------------
 drivers/usb/input/hid-input.c               |    1 
 fs/nfsd/nfs2acl.c                           |    2 -
 fs/nfsd/nfs3acl.c                           |    2 -
 include/linux/rtnetlink.h                   |    4 +++
 include/net/xfrm.h                          |    1 
 include/scsi/scsi_cmnd.h                    |    1 
 kernel/params.c                             |    2 -
 net/8021q/vlan_dev.c                        |    3 ++
 net/bridge/br_netfilter.c                   |   17 +++++---------
 net/ipv4/ip_gre.c                           |    2 -
 net/ipv4/netfilter/Makefile                 |    3 +-
 net/ipv4/netfilter/ip_conntrack_netlink.c   |    4 +--
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    3 +-
 net/ipv6/addrconf.c                         |   16 ++++++++++---
 net/ipv6/netfilter/Kconfig                  |    2 -
 net/ipv6/route.c                            |    2 -
 net/xfrm/xfrm_policy.c                      |   19 +++++++++++-----
 net/xfrm/xfrm_state.c                       |    5 ++++
 25 files changed, 108 insertions(+), 98 deletions(-)

Summary of changes from v2.6.14.4 to v2.6.14.5
==============================================

Andreas Gruenbacher:
      setting ACLs on readonly mounted NFS filesystems (CVE-2005-3623)

Bart De Schuymer:
      Fix bridge-nf ipv6 length check

David S. Miller:
      Perform SA switchover immediately.

Dmitry Torokhov:
      Input: fix an OOPS in HID driver

Greg Kroah-Hartman:
      Linux 2.6.14.5

Herbert Xu:
      Fix hardware checksum modification

Jason Wessel:
      kernel/params.c: fix sysfs access with CONFIG_MODULES=n

Kristian Slavov:
      Fix RTNLGRP definitions in rtnetlink.h

Krzysztof Oledzki:
      Fix CTA_PROTO_NUM attribute size in ctnetlink

Patrick McHardy:
      Fix unbalanced read_unlock_bh in ctnetlink
      Fix NAT init order
      Fix incorrect dependency for IP6_NF_TARGET_NFQUEUE

Salyzyn, Mark:
      dpt_i2o fix for deadlock condition

Stefan Richter:
      SCSI: fix transfer direction in sd (kernel panic when ejecting iPod)
      SCSI: fix transfer direction in scsi_lib and st

Stephen Hemminger:
      Fix hardware rx csum errors

YOSHIFUJI Hideaki:
      Fix route lifetime.

Yu Luming:
      apci: fix NULL deref in video/lcd/brightness

