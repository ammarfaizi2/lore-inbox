Return-Path: <linux-kernel-owner+w=401wt.eu-S932293AbXAGAqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXAGAqJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXAGAqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:46:09 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:54758 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbXAGAqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:46:07 -0500
X-Greylist: delayed 1774 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 19:46:07 EST
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG in inotify.c
Date: Sun, 7 Jan 2007 01:16:11 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701070116.11313.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

today I got following bug on my 2.6.20-rc3 vanilla kernel:

BUG: at fs/inotify.c:172 set_dentry_child_flags()
 [<c0179b74>] set_dentry_child_flags+0x5e/0x149
 [<c0179cb2>] remove_watch_no_event+0x53/0x5f
 [<c0179da0>] inotify_remove_watch_locked+0x12/0x3e
 [<c0179ee2>] inotify_rm_wd+0x6c/0x89
 [<c017a58a>] sys_inotify_rm_watch+0x38/0x4f
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] fib_validate_source+0x1d8/0x22d
 =======================
BUG: at fs/inotify.c:172 set_dentry_child_flags()
 [<c0179b74>] set_dentry_child_flags+0x5e/0x149
 [<c017a151>] inotify_add_watch+0xb8/0xff
 [<c017abc4>] sys_inotify_add_watch+0x10b/0x147
 [<c0179e59>] put_inotify_watch+0x21/0x3e
 [<c0179ef7>] inotify_rm_wd+0x81/0x89
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] fib_validate_source+0x1d8/0x22d
 =======================

Distro Debian testing 

# uname -a
Linux notas 2.6.20-rc3 #3 PREEMPT Thu Jan 4 11:28:04 CET 2007 i686 GNU/Linux

Thanks for fixing!

Michal
