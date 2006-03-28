Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWC1H7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWC1H7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWC1H7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:59:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:673 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751362AbWC1H7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:59:32 -0500
Date: Mon, 27 Mar 2006 23:59:11 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.15.7
Message-ID: <20060328075911.GA8097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.7 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15.6 and 2.6.15.7, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                            |    2 -
 drivers/infiniband/ulp/srp/ib_srp.c |    6 +++
 drivers/media/video/Kconfig         |    1 
 fs/compat_ioctl.c                   |    2 -
 fs/cramfs/inode.c                   |   60 +++++++++++++++++-------------------
 fs/ext2/dir.c                       |   28 +++++++---------
 net/core/sock.c                     |    5 +--
 net/ipv4/ip_output.c                |    6 ---
 net/ipv4/netfilter/ip_queue.c       |    2 -
 net/ipv6/netfilter/ip6_queue.c      |    2 -
 10 files changed, 56 insertions(+), 58 deletions(-)


Summary of changes from v2.6.15.6 to v2.6.15.7
==============================================

Al Viro:
      Fix ext2 readdir f_pos re-validation logic

Alexey Kuznetsov:
      TCP: Do not use inet->id of global tcp_socket when sending RST (CVE-2006-1242)

Dave Johnson:
      cramfs mounts provide corrupted content since 2.6.15

David S. Miller:
      Netfilter ip_queue: Fix wrong skb->len == nlmsg_len assumption
      NET: Ensure device name passed to SO_BINDTODEVICE is NULL terminated.

Greg Kroah-Hartman:
      Linux 2.6.15.7

Michael Krufky:
      Kconfig: VIDEO_DECODER must select FW_LOADER

Randy Dunlap:
      compat ifconf: fix limits

Roland Dreier:
      IB/srp: Don't send task management commands after target removal


