Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUEKKen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUEKKen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 06:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUEKKen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 06:34:43 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:27252 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262625AbUEKKeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 06:34:25 -0400
Message-ID: <40A0AC2E.1060209@blueyonder.co.uk>
Date: Tue, 11 May 2004 11:34:22 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.6-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2004 10:34:26.0451 (UTC) FILETIME=[886EB630:01C43743]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Oops on x86_only, x86_64 is OK.
See previous post. The kernel boots when compiled with PREEMPT no set. 
Also the nvidia video driver fails to build (4KSTACKS patch reversed), 
with or without nvidia_agp and agpgart in the kernel. SuSE 9.1, nForce2 
chipset and Athlon 2800+.
barrabas:/ftp/apr04 # gcc -v
Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --enable-languages=c,c++,f77,objc,java,ada 
--disable-checking --libdir=/usr/lib --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i586-suse-linux
Thread model: posix
gcc version 3.3.3 (SuSE Linux)

-> Kernel source path: '/lib/modules/2.6.6-mm1/build'
-> Performing cc_version_check with CC="cc".
-> Cleaning kernel module build directory.
   executing: 'cd ./usr/src/nv; make clean'...
   rm -f -f nv.o os-agp.o os-interface.o os-registry.o nv.o os-agp.o 
os-interfa
   ce.o os-registry.o nvidia.mod.o
   rm -f -f build-in.o nv-linux.o *.d .*.{cmd,flags}
   rm -f -f nvidia.{o,ko,mod.{o,c}} nv_compiler.h *~
-> Building kernel module:
   executing: 'cd ./usr/src/nv; make module 
SYSSRC=/lib/modules/2.6.6-mm1/build
   '...
   echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -n 1`\" > 
/tmp/selfgz9194/NVI
   DIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv_compiler.h
     CC [M]  /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.o
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:14,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:18,
                    from include/linux/module.h:10,
                    from 
/tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src
   /nv/nv-linux.h:52,
                    from 
/tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src
   /nv/nv.c:14:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used 
in arith
   metic
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In 
function
   `nvos_malloc_pages':
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:385: 
warning:
   use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In 
function
   `nvos_create_alloc':
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:513: 
warning:
   use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:523: 
warning:
   use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: At 
top level
   :
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1185: 
warning
   : initialization from incompatible pointer type
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In 
function
   `nv_alloc_file_private':
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1193: 
warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1204: 
warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In 
function
   `nv_kern_open':
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1265: 
warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In 
function
   `nv_kern_ctl_open':
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1914: 
warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: At 
top level
   :
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2010: 
error:
   conflicting types for `nv_set_hotkey_occurred_flag'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:350: 
error: p
   revious declaration of `nv_set_hotkey_occurred_flag'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2197: 
error:
   conflicting types for `nv_find_nv_mapping'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:339: 
error: p
   revious declaration of `nv_find_nv_mapping'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2269: 
error:
   conflicting types for `nv_find_agp_kernel_mapping'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:341: 
error: p
   revious declaration of `nv_find_agp_kernel_mapping'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2345: 
error:
   conflicting types for `nv_get_kern_phys_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:342: 
error: p
   revious declaration of `nv_get_kern_phys_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2375: 
error:
   conflicting types for `nv_get_user_phys_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:343: 
error: p
   revious declaration of `nv_get_user_phys_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2406: 
error:
   conflicting types for `nv_alloc_pages'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:353: 
error: p
   revious declaration of `nv_alloc_pages'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2594: 
error:
   conflicting types for `nv_free_pages'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:354: 
error: p
   revious declaration of `nv_free_pages'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2692: 
error:
   conflicting types for `nv_lock_rm'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:345: 
error: p
   revious declaration of `nv_lock_rm'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2712: 
error:
   conflicting types for `nv_unlock_rm'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:346: 
error: p
   revious declaration of `nv_unlock_rm'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2726: 
error:
   conflicting types for `nv_lock_heap'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:347: 
error: p
   revious declaration of `nv_lock_heap'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2736: 
error:
   conflicting types for `nv_unlock_heap'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:348: 
error: p
   revious declaration of `nv_unlock_heap'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2752: 
error:
   conflicting types for `nv_post_event'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:363: 
error: p
   revious declaration of `nv_post_event'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2790: 
error:
   conflicting types for `nv_get_event'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:364: 
error: p
   revious declaration of `nv_get_event'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2833: 
error:
   conflicting types for `nv_agp_init'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:356: 
error: p
   revious declaration of `nv_agp_init'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2895: 
error:
   conflicting types for `nv_agp_teardown'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:357: 
error: p
   revious declaration of `nv_agp_teardown'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2936: 
error:
   conflicting types for `nv_agp_translate_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:358: 
error: p
   revious declaration of `nv_agp_translate_address'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2968: 
error:
   conflicting types for `nv_int10h_call'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:351: 
error: p
   revious declaration of `nv_int10h_call'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2977: 
error:
   conflicting types for `nv_start_rc_timer'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:360: 
error: p
   revious declaration of `nv_start_rc_timer'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2998: 
error:
   conflicting types for `nv_stop_rc_timer'
   /tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:361: 
error: p
   revious declaration of `nv_stop_rc_timer'
   make[3]: *** 
[/tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.o
   ] Error 1
   make[2]: *** 
[/tmp/selfgz9194/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv] Err
   or 2
   nvidia.ko failed to build!
   make[1]: *** [module] Error 1
   make: *** [module] Error 2
-> Error.
ERROR: Unable to build the NVIDIA kernel module.
ERROR: Installation has failed.  Please see the file
       '/var/log/nvidia-installer.log' for details.  You may find 
suggestions
       on fixing installation problems in the README available on the Linux
       driver download page at www.nvidia.com.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

