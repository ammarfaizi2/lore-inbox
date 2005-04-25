Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVDYPnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVDYPnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVDYPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:39:46 -0400
Received: from chello212017098056.surfer.at ([212.17.98.56]:19218 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S262668AbVDYPXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:23:55 -0400
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200504251519.j3PFJUV14846@hofr.at>
Subject: profiling 2.4.X gcov problem 
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Apr 2005 17:19:30 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ia32 platform:
kernel linux-2.4.25 
kernel-patch-gcov-0.5 applied
gcov configuration:

#
# GCOV coverage profiling
#
CONFIG_GCOV_PROFILE=y
CONFIG_GCOV_ALL=y
CONFIG_GCOV_PROC=y

the data files are generated as expected - copied them into the kernel tree
touched all c,h files and reran make bzImage - it runs for quite some time
obviously using the .da files (for those where there are none warnings are 
issued) and then fails with the below error. 

 Can anybody suggest what could cause this error ? No make clean/distclean/mrproper or the like was run between the generation of the profiling data and the recompilation ?

init/version.c:0: warning: file init/version.da not found, execution counts assumed to be zero
vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data type
vt.c: In function `complete_change_console':
vt.c:1244: error: Profile does not match flowgraph of function complete_change_console (out of date?)
make[3]: *** [vt.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_char] Error 2
make: *** [_dir_drivers] Error 2

thx !
hofrat
