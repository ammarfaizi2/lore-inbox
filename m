Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTABA6p>; Wed, 1 Jan 2003 19:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTABA6p>; Wed, 1 Jan 2003 19:58:45 -0500
Received: from shell4.BAYAREA.NET ([209.128.82.1]:9231 "EHLO
	shell4.bayarea.net") by vger.kernel.org with ESMTP
	id <S265255AbTABA6o>; Wed, 1 Jan 2003 19:58:44 -0500
Message-ID: <3E139144.9020806@bayarea.net>
Date: Wed, 01 Jan 2003 17:09:24 -0800
From: Randy Broman <rbroman@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rbroman@bayarea.net
Subject: RH7.3 Updates - Compile Issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a working RH7.3 system with a stock 2.4.18-3 kernel. "Working"
included previous ability to compile a variety of software successfully,
although I had never compiled a new kernel.

With the intention of compiling a custom kernel I installed the following
software from Red Hat 7.3 Updates as follows: 

cpp-2.96-113.i386.rpm
gcc-2.96-113.i386.rpm
gcc-c++-2.96-113.i386.rpm
gcc-chill-2.96-113.i386.rpm
gcc-g77-2.96-113.i386.rpm
libstdc++-2.96-113.i386.rpm
libstdc++-devel-2.96-113.i386.rpm
binutils-2.11.93.0.2-11.i386.rpm
glibc-2.2.5-42.i386.rpm
glibc-common-2.2.5-42.i386.rpm
glibc-kernheaders-2.4-7.16.i386.rpm
kernel-source-2.4.18-19.7.x.i386.rpm

Unable to compile kernel, with the error messages below. Carefully went thru
.config file, reran after make clean/mrproper, etc. Make dep looks OK, but ...

#make bzImage
etc, etc, then ....

gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-19.7.x/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I 
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include -DKBUILD_BASENAME=serial  
-DEXPORT_SYMTAB -c serial.c
serial.c: In function `rs_read_proc':
serial.c:3361: Internal error: Segmentation fault.
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[3]: *** [serial.o] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.18-19.7.x/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.18-19.7.x/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-19.7.x/drivers'
make: *** [_dir_drivers] Error 2


I then did some further testing and found I was unable to compile some
software that previously compiled successfully. Ideas appreciated ..

Pls cc me personally on responses ... thx, Randy


