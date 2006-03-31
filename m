Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWCaVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCaVTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCaVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:19:44 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:45061 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932420AbWCaVTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:19:43 -0500
X-IronPort-AV: i="4.03,152,1141632000"; 
   d="scan'208"; a="1790731568:sNHT33168244"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, bos@pathscale.com
Subject: [git pull] InfiniBand: Add PathScale driver
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 31 Mar 2006 13:19:41 -0800
Message-ID: <adasloyxqfm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2006 21:19:41.0860 (UTC) FILETIME=[D33B0E40:01C65508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes, which add the ipath driver
for PathScale HCAs:

Bryan O'Sullivan:
      IB/ipath: core device driver
      IB/ipath: core driver header files
      IB/ipath: support for HyperTransport devices
      IB/ipath: support for PCI Express devices
      IB/ipath: chip initialisation code, and diag support
      IB/ipath: misc driver support code
      IB/ipath: sysfs and ipathfs support for core driver
      IB/ipath: support for userspace apps using core driver
      IB/ipath: layering interfaces used by higher-level driver code
      IB/ipath: infiniband header files
      IB/ipath: infiniband UC and UD protocol support
      IB/ipath: infiniband RC protocol support
      IB/ipath: misc infiniband code, part 1
      IB/ipath: misc infiniband code, part 2
      IB/ipath: infiniband verbs support
      IB/ipath: kbuild infrastructure

 MAINTAINERS                                     |    6 
 drivers/Makefile                                |    1 
 drivers/infiniband/Kconfig                      |    1 
 drivers/infiniband/Makefile                     |    1 
 drivers/infiniband/hw/ipath/Kconfig             |   16 
 drivers/infiniband/hw/ipath/Makefile            |   36 
 drivers/infiniband/hw/ipath/ipath_common.h      |  616 +++++++
 drivers/infiniband/hw/ipath/ipath_cq.c          |  295 +++
 drivers/infiniband/hw/ipath/ipath_debug.h       |   96 +
 drivers/infiniband/hw/ipath/ipath_diag.c        |  379 ++++
 drivers/infiniband/hw/ipath/ipath_driver.c      | 1983 +++++++++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_eeprom.c      |  613 +++++++
 drivers/infiniband/hw/ipath/ipath_file_ops.c    | 1910 ++++++++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_fs.c          |  605 +++++++
 drivers/infiniband/hw/ipath/ipath_ht400.c       | 1586 ++++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_init_chip.c   |  951 +++++++++++
 drivers/infiniband/hw/ipath/ipath_intr.c        |  841 ++++++++++
 drivers/infiniband/hw/ipath/ipath_kernel.h      |  884 ++++++++++
 drivers/infiniband/hw/ipath/ipath_keys.c        |  236 +++
 drivers/infiniband/hw/ipath/ipath_layer.c       | 1515 ++++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_layer.h       |  181 ++
 drivers/infiniband/hw/ipath/ipath_mad.c         | 1352 ++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_mr.c          |  383 ++++
 drivers/infiniband/hw/ipath/ipath_pe800.c       | 1247 ++++++++++++++
 drivers/infiniband/hw/ipath/ipath_qp.c          |  913 +++++++++++
 drivers/infiniband/hw/ipath/ipath_rc.c          | 1857 ++++++++++++++++++++++
 drivers/infiniband/hw/ipath/ipath_registers.h   |  446 +++++
 drivers/infiniband/hw/ipath/ipath_ruc.c         |  552 ++++++
 drivers/infiniband/hw/ipath/ipath_srq.c         |  273 +++
 drivers/infiniband/hw/ipath/ipath_stats.c       |  303 ++++
 drivers/infiniband/hw/ipath/ipath_sysfs.c       |  778 +++++++++
 drivers/infiniband/hw/ipath/ipath_uc.c          |  645 +++++++
 drivers/infiniband/hw/ipath/ipath_ud.c          |  621 +++++++
 drivers/infiniband/hw/ipath/ipath_user_pages.c  |  207 ++
 drivers/infiniband/hw/ipath/ipath_verbs.c       | 1222 ++++++++++++++
 drivers/infiniband/hw/ipath/ipath_verbs.h       |  697 ++++++++
 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c |  333 ++++
 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c   |  157 ++
 drivers/infiniband/hw/ipath/ips_common.h        |  263 +++
 drivers/infiniband/hw/ipath/verbs_debug.h       |  107 +
 40 files changed, 25108 insertions(+), 0 deletions(-)
 create mode 100644 drivers/infiniband/hw/ipath/Kconfig
 create mode 100644 drivers/infiniband/hw/ipath/Makefile
 create mode 100644 drivers/infiniband/hw/ipath/ipath_common.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_cq.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_debug.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_diag.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_driver.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_eeprom.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_file_ops.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_fs.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_ht400.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_init_chip.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_intr.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_kernel.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_keys.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_layer.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_layer.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_mad.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_mr.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_pe800.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_qp.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_rc.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_registers.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_ruc.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_srq.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_stats.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_sysfs.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_uc.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_ud.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_user_pages.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_verbs.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_verbs.h
 create mode 100644 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
 create mode 100644 drivers/infiniband/hw/ipath/ips_common.h
 create mode 100644 drivers/infiniband/hw/ipath/verbs_debug.h
