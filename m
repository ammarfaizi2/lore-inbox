Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJLTqd>; Sat, 12 Oct 2002 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJLTqd>; Sat, 12 Oct 2002 15:46:33 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:39151 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S261339AbSJLTqc>; Sat, 12 Oct 2002 15:46:32 -0400
Message-ID: <XFMail.20021012155110.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sat, 12 Oct 2002 15:51:10 -0400 (EDT)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre10 compile fails to link  init_rootfs if CONFIG_RAMFS != y
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject line says it all:

This needs fixing in linux-2.4.20pre*: 

--   a function in fs/namespace.c calls init_rootfs(),

--   This is declared as "extern void init_rootfs(void)" in fs/namespace.c,
     But " __init int init_rootfs(void)" *only* occurs
     in fs/ramfs/inode.c, and is not compiled unless CONFIG_RAMFS=y.
     If CONFIG_RAMFS !=y, "make fs" fails (can't link init_rootfs).


Who should this report go to?
(I found that this was already briefly alluded to
on this list a few months ago, but seems to have been ignored....)

----------------------------------
E-Mail: Duncan Haldane <duncan_haldane@users.sourceforge.net>
Date: 12-Oct-2002
Time: 15:13:22

This message was sent by XFMail
----------------------------------
