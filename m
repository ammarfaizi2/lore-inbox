Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWFLMW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWFLMW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWFLMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:22:29 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:15527 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751905AbWFLMW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:22:29 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] fuse: file locking + misc
Message-Id: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:21:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add POSIX file locking to the fuse interface.

Additional changes ralated to this are:

  - asynchronous interrupt of requests by SIGKILL no longer supported

  - separate control filesystem, instead of using sysfs objects

  - add support for synchronously interrupting requests

Details are documented in Documentation/filesystems/fuse.txt
throughout the patches.

Note: this series depends on

  vfs-add-lock-owner-argument-to-flush-operation.patch

to compile and to some extent on

  remove-steal_locks.patch

to work correctly.

Miklos
