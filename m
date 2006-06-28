Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423161AbWF1FYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423161AbWF1FYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423181AbWF1FXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:23:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6606 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423176AbWF1FTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:24 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 31/31] Remove in-kernel root-mounting code
Date: Tue, 27 Jun 2006 22:17:31 -0700
Message-Id: <klibc.200606272217.31@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Remove in-kernel root-mounting code

This removes the root mounting code from the kernel proper.  This
includes ip autoconfiguration, nfsroot, and name_to_dev_t().

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 8a5ac82c851f56902095db4b78150bac5ea532a6
tree d62b2a5763d9becb8bd37ddc0e69d65eb477b3c5
parent 72226912c1128958df215fcfc10b91f4e27bfa79
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:23 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:23 -0700

 arch/i386/kernel/setup.c   |    8 
 arch/x86_64/kernel/setup.c |    7 
 fs/Kconfig                 |   14 
 fs/nfs/Makefile            |    1 
 fs/nfs/mount_clnt.c        |  191 ------
 fs/nfs/nfsroot.c           |  525 ---------------
 include/linux/mount.h      |    1 
 init/Makefile              |    8 
 init/do_mounts.c           |  437 -------------
 init/do_mounts.h           |   91 ---
 init/do_mounts_devfs.c     |  137 ----
 init/do_mounts_initrd.c    |  125 ----
 init/do_mounts_md.c        |  286 --------
 init/do_mounts_rd.c        |  429 -------------
 init/initramfs.c           |    3 
 init/main.c                |   45 -
 net/ipv4/Makefile          |    1 
 net/ipv4/ipconfig.c        | 1510 --------------------------------------------
 18 files changed, 21 insertions(+), 3798 deletions(-)

Patch suppressed due to size (103 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/31-remove-in-kernel-root-mounting-code.patch
