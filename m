Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUEROj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUEROj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUEROj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:39:29 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:38537 "EHLO
	vsmtp3alice.tin.it") by vger.kernel.org with ESMTP id S263419AbUEROjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:39:23 -0400
From: The Jackal <jackal@capitanlug.it>
Reply-To: jackal@capitanlug.it
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: make menuconfig command with kernel 2.6.4
Date: Tue, 18 May 2004 16:40:12 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405181640.12253.jackal@capitanlug.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.. I have a problem with the makeconfig command.
Is this a problem of my system or a kernel/compiler bug?!


Here the output of my bash:

root@Anubis:/usr/src/linux-2.6.4# make oldconfig
  HOSTCC  scripts/basic/fixdep
In file included from /usr/include/bits/posix1_lim.h:126,
                 from /usr/include/limits.h:144,
                 from /usr/lib/gcc-lib/i486-slackware-linux/3.3.3/include/limits.h:122,
                 from /usr/lib/gcc-lib/i486-slackware-linux/3.3.3/include/syslimits.h:7,
                 from /usr/lib/gcc-lib/i486-slackware-linux/3.3.3/include/limits.h:11,
                 from scripts/basic/fixdep.c:105:
/usr/include/bits/local_lim.h:36:26: linux/limits.h: No such file or directory
In file included from /usr/include/netinet/in.h:212,
                 from scripts/basic/fixdep.c:107:
/usr/include/bits/socket.h:305:24: asm/socket.h: No such file or directory
scripts/basic/fixdep.c: In function `use_config':
scripts/basic/fixdep.c:193: error: `PATH_MAX' undeclared (first use in this 
function)
scripts/basic/fixdep.c:193: error: (Each undeclared identifier is reported 
only once
scripts/basic/fixdep.c:193: error: for each function it appears in.)
scripts/basic/fixdep.c:193: warning: unused variable `s'
scripts/basic/fixdep.c: In function `parse_dep_file':
scripts/basic/fixdep.c:289: error: `PATH_MAX' undeclared (first use in this 
function)
scripts/basic/fixdep.c:289: warning: unused variable `s'
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2
root@Anubis:/usr/src/linux-2.6.4#


And here the ver_linux script output:

root@Anubis:/usr/src/linux-2.6.4/scripts# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux Anubis 2.6.4 #2 SMP Sat Mar 27 17:30:32 CET 2004 i686 unknown unknown 
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
pcmcia-cs              3.2.7
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.18
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         yenta_socket pcmcia_core
root@Anubis:/usr/src/linux-2.6.4/scripts#


Thanks and regards,

The Jackal
