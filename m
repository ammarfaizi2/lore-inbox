Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313403AbSC2Iic>; Fri, 29 Mar 2002 03:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313404AbSC2IiX>; Fri, 29 Mar 2002 03:38:23 -0500
Received: from lsanca1-220-085.lsanca1.dsl.gtei.net ([4.3.220.85]:62988 "EHLO
	vhost2.connect4less.com") by vger.kernel.org with ESMTP
	id <S313403AbSC2IiP>; Fri, 29 Mar 2002 03:38:15 -0500
Message-ID: <3CA411C8.7090701@connect4less.com>
Date: Thu, 28 Mar 2002 23:03:36 -0800
From: "David Christensen" <davidc@connect4less.com>
Organization: Connect4Less, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Modular Frustration w/2.4.18!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand it!  I cannot seem to get the modules to compile on 
my box!  Every time I modify the config to make something compile NOT as 
a module, the make breaks somewhere else!  ARRRRGHHH!

The lay of the land:
gcc-cpp-2.96-0.76mdk
gcc-2.96-0.76mdk
gcc-c++-2.96-0.76mdk
libgcc3.0-3.0.4-2mdk


I can do a "make bzImage" and that compiles just fine:
 >>>SNIP
tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > bzImage
Root device is (8, 21)
Boot sector 512 bytes.
Setup is 4796 bytes.
System is 718 kB
make[1]: Leaving directory `/usr/src/linux-2.4.18-6mdk/arch/i386/boot'
[root@pluto linux]#


Then when I get to making the modules... BOOM!
 >>>SNIP
In file included from /usr/src/linux-2.4.18-6mdk/include/linux/highmem.h:5,
                  from 
/usr/src/linux-2.4.18-6mdk/include/linux/pagemap.h:16,
                  from /usr/src/linux-2.4.18-6mdk/include/linux/locks.h:8,
                  from 
/usr/src/linux-2.4.18-6mdk/include/linux/devfs_fs_kernel.h:6,
                  from floppy.c:169:
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
`get_pgd_fast':
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:78: 
`boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:78: (Each undeclared 
identifier is reported only once
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:78: for each function 
it appears in.)
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
`free_pgd_fast':
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:89: 
`boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
`pte_alloc_one_fast':
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:127: 
`boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h: In function 
`pte_free_fast':
/usr/src/linux-2.4.18-6mdk/include/asm/pgalloc.h:137: 
`boot_cpu_data_Rsmp_0657d037' undeclared (first use in this function)
make[2]: *** [floppy.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers'
make: *** [_mod_drivers] Error 2

