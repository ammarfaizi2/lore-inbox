Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSFEP6F>; Wed, 5 Jun 2002 11:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSFEP6E>; Wed, 5 Jun 2002 11:58:04 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:61363 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S315463AbSFEP6D>; Wed, 5 Jun 2002 11:58:03 -0400
Date: Wed, 5 Jun 2002 10:57:58 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Two errors, kernel 2.5.20
Message-ID: <20020605105758.C2745@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/local/src/kernel/linux-2.5.20/include -Wall -Wstrict-pro           totypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common            -pipe -mpreferred-stack-boundary=2 -march=i686    -DKBUILD_BASENAME=suspend -DE           XPORT_SYMTAB -c -o suspend.o suspend.c
suspend.c:305: #error this is broken, FIXME
suspend.c: In function `freeze_processes':
suspend.c:234: warning: implicit declaration of function `signal_wake_up'
suspend.c: In function `fill_suspend_header':
suspend.c:286: warning: comparison between pointer and integer
suspend.c: In function `do_suspend_sync':
suspend.c:306: `tq_disk' undeclared (first use in this function)
suspend.c:306: (Each undeclared identifier is reported only once
suspend.c:306: for each function it appears in.)
suspend.c: In function `write_suspend_image':
suspend.c:431: warning: passing arg 3 of `get_swaphandle_info' from incompatible            pointer type
suspend.c:430: warning: unused variable `dummy2'
suspend.c: In function `suspend_save_image':
suspend.c:724: warning: assignment makes integer from pointer without a cast
suspend.c: In function `resume_try_to_read':
suspend.c:1059: warning: passing arg 1 of `name_to_kdev_t' discards qualifiers f           rom pointer target type
suspend.c:1067: warning: unsigned int format, kdev_t arg (arg 2)
suspend.c:1057: warning: unused variable `blksize'
suspend.c: At top level:
suspend.c:1221: warning: static declaration for `resume_setup' follows non-stati           c
make[1]: *** [suspend.o] Error 1
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.20/kernel'
make: *** [kernel] Error 2

and

gcc -D__KERNEL__ -I/usr/local/src/kernel/linux-2.5.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -include /usr/local/src/kernel/linux-2.5.20/include/linux/modversions.h   -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c: In function `hfs_prepare_write':
inode.c:242: dereferencing pointer to incomplete type
make[2]: *** [inode.o] Error 1
make[2]: Leaving directory `/usr/local/src/kernel/linux-2.5.20/fs/hfs'
make[1]: *** [_modsubdir_hfs] Error 2
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.20/fs'
make: *** [_mod_fs] Error 2

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
"Ich bin ein Penguin."  --/. poster mmarlett, responding to news that the
  Bundestag will move to IBM/SuSE Linux.  
                      http://slashdot.org/comments.pl?sid=33588&cid=3631032
