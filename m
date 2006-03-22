Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWCVAbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWCVAbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCVAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:31:13 -0500
Received: from xenotime.net ([66.160.160.81]:3472 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751872AbWCVAbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:31:12 -0500
Date: Tue, 21 Mar 2006 16:33:21 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH/RFC] expose Doc/ source files
Message-Id: <20060321163321.34ccda19.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

I propose that we expose example and tool source files in the
Documentation/ directory in their own files instead of being
buried (almost hidden) in readme/txt or shar files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/block/ionice.c                       |  110 
 Documentation/block/ioprio.txt                     |  118 
 Documentation/dnotify.txt                          |   38 
 Documentation/dnotify_example.c                    |   34 
 Documentation/dslm.c                               |  165 +
 Documentation/hpet.txt                             |  272 -
 Documentation/hpet_example.c                       |  267 +
 Documentation/java.txt                             |  201 -
 Documentation/javaclassname.c                      |  194 +
 Documentation/jprobe-example.c                     |   56 
 Documentation/kprobe_example.c                     |   65 
 Documentation/kprobes.txt                          |  180 -
 Documentation/kretprobe-example.c                  |   53 
 Documentation/laptop-mode.txt                      |  168 -
 Documentation/mtrr-add.c                           |   96 
 Documentation/mtrr-show.c                          |   83 
 Documentation/mtrr.txt                             |  183 -
 Documentation/pcmcia/crc32hash.c                   |   32 
 Documentation/pcmcia/devicetable.txt               |   34 
 Documentation/rtc-test.c                           |  213 +
 Documentation/rtc.txt                              |  216 -
 Documentation/s390/Debugging390.txt                |   63 
 Documentation/s390/hex2ascii.c                     |   58 
 Documentation/sharedsubtree.txt                    |   79 
 Documentation/smount.c                             |   72 
 Documentation/sound/oss/MultiSound                 | 1509 ++---------
 Documentation/sound/oss/MultiSound.d/Makefile      |    8 
 Documentation/sound/oss/MultiSound.d/conv.l        |    8 
 Documentation/sound/oss/MultiSound.d/msndreset.c   |   55 
 Documentation/sound/oss/MultiSound.d/pinnaclecfg.c |  432 +++
 Documentation/sound/oss/MultiSound.d/setdigital.c  |   78 
 Documentation/sound/oss/rme96xx                    |  736 -----
 Documentation/sound/oss/rmectrl.c                  |  255 +
 Documentation/sound/oss/xrmectrl                   |  469 +++
 Documentation/video4linux/CQcam.txt                |  204 -
 Documentation/video4linux/v4lgrab.c                |  192 +
 Documentation/vm/hugepage-mmap.c                   |   74 
 Documentation/vm/hugepage-shm.c                    |   71 
 Documentation/vm/hugetlbpage.txt                   |  150 -
 Documentation/watchdog/pcwd-watchdog.txt           |   73 
 Documentation/watchdog/watchdog-api.txt            |   14 
 Documentation/watchdog/watchdog-simple.c           |   19 
 Documentation/watchdog/watchdog-test.c             |   68 
 Documentation/watchdog/watchdog.txt                |   23 
 44 files changed, 3634 insertions(+), 3854 deletions(-)
---

patch file (234 KB) is at:
http://www.xenotime.net/linux/patches/linux-2616-doc-sources.patch

Note:  Several source files in Documentation/ have build errors.
I have patches for those also, but I'll wait on sending those.
---
