Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290295AbSAPAFc>; Tue, 15 Jan 2002 19:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSAPAFS>; Tue, 15 Jan 2002 19:05:18 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:47497 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290268AbSAPAFM>; Tue, 15 Jan 2002 19:05:12 -0500
Message-ID: <3C44C3B6.8060900@nyc.rr.com>
Date: Tue, 15 Jan 2002 19:05:10 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.3-pre1 compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686    -c -o read_write.o read_write.c
In file included from read_write.c:10:
/usr/src/linux-2.5.2/include/linux/file.h:25: parse error before `atomic_t'
/usr/src/linux-2.5.2/include/linux/file.h:25: warning: no semicolon at 
end of struct or union
/usr/src/linux-2.5.2/include/linux/file.h:36: parse error before `}'
/usr/src/linux-2.5.2/include/linux/file.h: In function `fcheck_files':
/usr/src/linux-2.5.2/include/linux/file.h:50: dereferencing pointer to 
incomplete type
/usr/src/linux-2.5.2/include/linux/file.h:51: dereferencing pointer to 
incomplete type
In file included from read_write.c:13:
/usr/src/linux-2.5.2/include/linux/dnotify.h: At top level:
/usr/src/linux-2.5.2/include/linux/dnotify.h:18: warning: `struct inode' 
declared inside parameter list
/usr/src/linux-2.5.2/include/linux/dnotify.h:18: warning: its scope is 
only this definition or declaration, which is probably not what you want.
/usr/src/linux-2.5.2/include/linux/dnotify.h:21: warning: `struct inode' 
declared inside parameter list
/usr/src/linux-2.5.2/include/linux/dnotify.h: In function 
`inode_dir_notify':
/usr/src/linux-2.5.2/include/linux/dnotify.h:23: dereferencing pointer 
to incomplete type
/usr/src/linux-2.5.2/include/linux/dnotify.h:24: warning: passing arg 1 
of `__inode_dir_notify' from incompatible pointer type
read_write.c: In function `sys_read':
read_write.c:167: warning: passing arg 1 of `inode_dir_notify' from 
incompatible pointer type
read_write.c: In function `sys_write':
read_write.c:194: warning: passing arg 1 of `inode_dir_notify' from 
incompatible pointer type
read_write.c: In function `do_readv_writev':
read_write.c:299: warning: passing arg 1 of `inode_dir_notify' from 
incompatible pointer type
read_write.c: In function `sys_pread':
read_write.c:371: warning: passing arg 1 of `inode_dir_notify' from 
incompatible pointer type
read_write.c: In function `sys_pwrite':
read_write.c:403: warning: passing arg 1 of `inode_dir_notify' from 
incompatible pointer type
make[2]: *** [read_write.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.2/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.2/fs'
make: *** [_dir_fs] Error 2

