Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUKGP5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUKGP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 10:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKGP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 10:57:25 -0500
Received: from [195.56.65.174] ([195.56.65.174]:7431 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261628AbUKGP5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 10:57:21 -0500
Subject: weird NFSv3 getaddr storm when fileserver upgraded to 2.6 (stale
	NFS fh)
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-2
Message-Id: <1099843036.28536.163.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 07 Nov 2004 16:57:16 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another problem with the 2.6.9 nfs server:

10_1_1_1:/# tar xfvz l269-p1.tgz
boot/
boot/ChangeLog-l269-p1
tar: boot/ChangeLog-l269-p1: Cannot open: Stale NFS file handle
boot/l269-p1
tar: boot/l269-p1: Cannot open: Stale NFS file handle
boot/System.map-l269
tar: boot/System.map-l269: Cannot open: Stale NFS file handle
boot/System.map-2.6.9
tar: boot/System.map-2.6.9: Cannot open: Stale NFS file handle
lib/
lib/modules/
tar: lib/modules: Cannot mkdir: Stale NFS file handle
lib/modules/2.6.9/
tar: lib/modules/2.6.9: Cannot mkdir: Stale NFS file handle
[...]
10_1_1_1:/# uname -a 
Linux 10_1_1_1 2.4.25 #4 SMP Thu Feb 19 22:54:19 CET 2004 i686 unknown
10_1_1_1:/# mkdir boot/test
10_1_1_1:/# ls -ld boot/test
drwxr-xr-x    2 root     root         4096 Nov  7 16:55 test
10_1_1_1:/# rmdir boot/test
10_1_1_1:/# tar xfvz l269-p1.tgz
boot/
boot/ChangeLog-l269-p1
tar: boot/ChangeLog-l269-p1: Cannot open: Stale NFS file handle
[...]


-- 
dap

--------------------------------------------
végülis mindegy is, tudtam hogy nem is jössz
este csillag,
nappal fecske

