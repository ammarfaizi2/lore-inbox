Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSFSDUu>; Tue, 18 Jun 2002 23:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSFSDUt>; Tue, 18 Jun 2002 23:20:49 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:52419 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317755AbSFSDUt>; Tue, 18 Jun 2002 23:20:49 -0400
Message-ID: <3D0FF715.7040601@linuxhq.com>
Date: Tue, 18 Jun 2002 23:14:30 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.23 cpu_online_map undeclared
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running on a UP system, so I don't believe that cpu_online_map 
should be declared.  Any suggestions?

   gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -nostdinc -iwithprefix include    -fno-omit-frame-pointer 
-DKBUILD_BASENAME=sched   -c -o sched.o sched.c
sched.c: In function `sys_sched_setaffinity':
sched.c:1332: `cpu_online_map' undeclared (first use in this function)
sched.c:1332: (Each undeclared identifier is reported only once
sched.c:1332: for each function it appears in.)
sched.c: In function `sys_sched_getaffinity':
sched.c:1391: `cpu_online_map' undeclared (first use in this function)
make[1]: *** [sched.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.23/kernel'
make: *** [kernel] Error 2


  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

