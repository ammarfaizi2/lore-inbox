Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSK1MQt>; Thu, 28 Nov 2002 07:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSK1MQs>; Thu, 28 Nov 2002 07:16:48 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:2440 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S265423AbSK1MQs>; Thu, 28 Nov 2002 07:16:48 -0500
Date: Thu, 28 Nov 2002 10:24:03 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: owner-xfs@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>, lord@oss.sgi.com,
       linux-xfs@oss.sgi.com, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH RESEND 2.5]FIX XFS redefines
Message-Id: <20021128102403.0aa17064.abslucio@terra.com.br>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello....

This patch fixes this redefines in linux-2.5.49 and 2.5.50 ...

In file included from fs/xfs/linux/xfs_linux.h:56,
                 from fs/xfs/xfs.h:54,
                 from fs/xfs/xfs_acl.c:33:
fs/xfs/linux/xfs_vnode.h:546: warning: `AT_UID' redefined
include/linux/elf.h:172: warning: this is the location of the previous definition
fs/xfs/linux/xfs_vnode.h:547: warning: `AT_GID' redefined
include/linux/elf.h:174: warning: this is the location of the previous definition
....

This happens, because linux/module.h is including linux/elf.h that define AT_UID and AT_GID (since 2.5.49) ...

i just renamed the XFS Attributes defines from AT_XXX to XFS_AT_XXX

best regards.
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net
