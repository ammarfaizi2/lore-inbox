Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWIQBrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWIQBrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWIQBrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:32 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:42181 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932120AbWIQBrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:31 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 11] Use SEEK_{SET,CUR,END} instead of hardcoded values
Message-Id: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:26 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In July, David Howells added SEEK_{SET,CUR,END} definitions to include/linux/fs.h

The following patches convert offenders which were found by grep'ing the source
tree.

Josef 'Jeff' Sipek

11 files changed, 34 insertions(+), 39 deletions(-)
drivers/char/mbcs.c                    |    7 ++++---
drivers/isdn/hardware/eicon/dsp_defs.h |    3 ---
drivers/mtd/mtdchar.c                  |   11 ++++-------
fs/cifs/cifsfs.c                       |    2 +-
fs/locks.c                             |   12 ++++++------
fs/nfs/file.c                          |    2 +-
fs/xfs/xfs_vnodeops.c                  |    6 +++---
sound/core/info.c                      |    6 +++---
sound/drivers/opl4/opl4_proc.c         |    6 +++---
sound/isa/gus/gus_mem_proc.c           |    6 +++---
sound/pci/mixart/mixart.c              |   12 ++++++------



