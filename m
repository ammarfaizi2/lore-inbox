Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVJJT43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVJJT43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVJJT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:56:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:27871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751185AbVJJT43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:56:29 -0400
Date: Mon, 10 Oct 2005 12:55:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.13.4
Message-ID: <20051010195542.GA12763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.13.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.13.3 and 2.6.13.4, as it is small enough to do so.

The updated 2.6.13.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.13.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                         |    2 +-
 arch/sparc64/kernel/entry.S      |   39 +++++++++++++++++++++------------------
 arch/sparc64/kernel/rtrap.S      |    7 ++++---
 arch/sparc64/lib/VISsave.S       |    8 +++++---
 drivers/char/drm/drm_stub.c      |    2 +-
 drivers/ieee1394/sbp2.c          |   38 +++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/orinoco.c   |   14 +++++++++-----
 fs/namei.c                       |    6 +++---
 net/ipv4/tcp_bic.c               |    2 +-
 security/keys/request_key_auth.c |    1 +
 10 files changed, 81 insertions(+), 38 deletions(-)

Summary of changes from v2.6.13.3 to v2.6.13.4
============================================

Dave Jones:
  Fix drm 'debug' sysfs permissions

David Howells:
  key: plug request_key_auth memleak (CAN-2005-3119)

David S. Miller:
  Fix userland FPU state corruption.

Greg Kroah-Hartman:
  Linux 2.6.13.4

Linus Torvalds:
  Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL

Pavel Roskin:
  orinoco: Information leakage due to incorrect padding

Stefan Richter:
  ieee1394/sbp2: fixes for hot-unplug and module unloading

Stephen Hemminger:
  BIC coding bug in Linux 2.6.13
