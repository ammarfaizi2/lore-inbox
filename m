Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292932AbSCRKQp>; Mon, 18 Mar 2002 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292940AbSCRKQg>; Mon, 18 Mar 2002 05:16:36 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64526 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S292932AbSCRKQ1>; Mon, 18 Mar 2002 05:16:27 -0500
Message-Id: <200203181013.g2IADTq27976@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [-ENOCOMPILE] raid5 as a module in linux-2.5.7-pre2
Date: Mon, 18 Mar 2002 12:13:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<abridged>

gcc -D__KERNEL__ -I/.share/usr/src/linux-2.5.7-pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i386 -DMODULE -DMODVERSIONS -include 
/.share/usr/src/linux-2.5.7-pre2/include/linux/modversions.h  
-DKBUILD_BASENAME=raid5  -c -o raid5.o raid5.c

In file included from raid5.c:23:
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:218: parse error 
before "md_wait_queue_head_t"
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:218: warning: no 
semicolon at end of struct or union
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:222: parse error 
before "device_lock"
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:222: warning: 
type defaults to `int' in declaration of `device_lock'
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:222: warning: 
data definition has no type or storage class
/.share/usr/src/linux-2.5.7-pre2/include/linux/raid/raid5.h:226: parse error 
before '}' token
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
...
raid5.c: In function `release_stripe':
raid5.c:94: dereferencing pointer to incomplete type
...
raid5.c: In function `insert_hash':
raid5.c:113: dereferencing pointer to incomplete type
...
raid5.c: In function `get_free_stripe':
raid5.c:131: dereferencing pointer to incomplete type
...
raid5.c:129: warning: `first' might be used uninitialized in this function
raid5.c: In function `__find_stripe':
raid5.c:238: warning: `sh' might be used uninitialized in this function
raid5.c: In function `get_active_stripe':
raid5.c:255: warning: implicit declaration of function `md_spin_lock_irq'
raid5.c:329: warning: implicit declaration of function `md_spin_unlock_irq'
raid5.c:329: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_read_request':
raid5.c:382: dereferencing pointer to incomplete type
raid5.c:397: dereferencing pointer to incomplete type
raid5.c:408: structure has no member named `b_reqnext'
raid5.c:409: structure has no member named `b_reqnext'
raid5.c:412: dereferencing pointer to incomplete type
raid5.c:421: dereferencing pointer to incomplete type
...
...
...
