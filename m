Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSHASb4>; Thu, 1 Aug 2002 14:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSHASb4>; Thu, 1 Aug 2002 14:31:56 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:14788 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316434AbSHASbz>; Thu, 1 Aug 2002 14:31:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: bad: schedule() with irqs disabled! - current bk tree
Date: Thu, 1 Aug 2002 14:35:03 -0400
X-Mailer: KMail [version 1.4]
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208011435.03271.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a bk tree current as of 7am Aug 1, I am getting repeated:

Aug  1 14:23:46 oscar kernel: bad: schedule() with irqs disabled!
Aug  1 14:23:46 oscar kernel: d1fdbe28 c0212be0 dffd0580 d1fdbe50 c010fea7 00000001 c029db68 fffffffe
Aug  1 14:23:46 oscar kernel:        d1fdbe4c 00000046 d1fdbe60 c010febb dffd0580 00000000 c029db60 c01178a1
Aug  1 14:23:46 oscar kernel:        d828d040 d1fda000 d1fdbeb4 d1fda000 00000246 c01fae7d 00000000 00000400
Aug  1 14:23:46 oscar kernel: Call Trace: [try_to_wake_up+255/264] [wake_up_process+11/16] [do_softirq+161/172] [tcp_get_info+1177/1288] [__alloc_pages+70/416]
Aug  1 14:23:46 oscar kernel:    [proc_file_read+131/380] [vfs_read+186/316] [sys_read+40/60] [syscall_call+7/11]

Sometimes a see a few per minute, other time 20 minutes may pass between occurances.

Only extra patch(s) applied are the floppy fix for 2.2.27 and a verson of slablru for 2.5.

Ideas?
Ed Tomlinson
