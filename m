Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264849AbUEPXhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbUEPXhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUEPXhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 19:37:37 -0400
Received: from mproxy.gmail.com ([216.239.56.240]:13424 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264849AbUEPXhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 19:37:33 -0400
Message-ID: <578614370405161637338477ab@mail.gmail.com>
Date: Sun, 16 May 2004 18:37:32 -0500
From: Jesus Delgado <jdelgado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Broken things in kernel 2.6.6-mm2 and 2.6.6-mm3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

      Kernel's 2.6.6 and previous 2.6.6-rcX-mmX working good with
modules ATI fglrx 3.7.6 and VMware 4.5.1.

       When running kernel 2.6.6-mm2 and 2.6.6.-mm3  the modules
broken in compilation, the messages is:

      VMware 4.5.1

     [root@toshiba root]# vmware-config.pl
Making sure VMware Workstation's services are stopped.
 
Stopping VMware services:
   Virtual machine monitor                                 [  OK  ]
   Bridged networking on /dev/vmnet0                       [  OK  ]
   DHCP server on /dev/vmnet8                              [  OK  ]
   NAT service on /dev/vmnet8                              [  OK  ]
   Host-only networking on /dev/vmnet8                     [  OK  ]
   Virtual ethernet                                        [  OK  ]
 
Trying to find a suitable vmmon module for your running kernel.
 
None of VMware Workstation's pre-built vmmon modules is suitable for your
running kernel.  Do you want this program to try to build the vmmon module for
your system (you need to have a C compiler installed on your system)? [yes]
 
Using compiler "/usr/bin/gcc". Use environment variable CC to override.
 
What is the location of the directory of C header files that match your running
kernel? [/lib/modules/2.6.6/build/include]
 
Extracting the sources of the vmmon module.
 
Building the vmmon module.
 
Using 2.6.x kernel build system.
make: Entering directory `/tmp/vmware-config2/vmmon-only'
make -C /lib/modules/2.6.6/build/include/.. SUBDIRS=$PWD SRCROOT=$PWD/. modules
make[1]: Entering directory `/usr/src/linux-2.6.6'
  CC [M]  /tmp/vmware-config2/vmmon-only/linux/driver.o
/tmp/vmware-config2/vmmon-only/linux/driver.c:131: warning:
initialization from incompatible pointer type
/tmp/vmware-config2/vmmon-only/linux/driver.c:135: warning:
initialization from incompatible pointer type
  CC [M]  /tmp/vmware-config2/vmmon-only/linux/hostif.o
/tmp/vmware-config2/vmmon-only/linux/hostif.c: In function
`HostIF_FreeLockedPages':
/tmp/vmware-config2/vmmon-only/linux/hostif.c:738: error: structure
has no member named `count'
/tmp/vmware-config2/vmmon-only/linux/hostif.c:740: error: structure
has no member named `count'
make[2]: *** [/tmp/vmware-config2/vmmon-only/linux/hostif.o] Error 1
make[1]: *** [/tmp/vmware-config2/vmmon-only] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.6'
make: *** [vmmon.ko] Error 2
make: Leaving directory `/tmp/vmware-config2/vmmon-only'
Unable to build the vmmon module.
 
For more information on how to troubleshoot module-related problems, please
visit our Web site at "http://www.vmware.com/download/modules/modules.html" and
"http://www.vmware.com/support/reference/linux/prebuilt_modules_linux.html".
 
Execution aborted.


   ATI fglrx 3.7.6

[root@toshiba build_mod]# ./make.sh
ATI module generator V 2.0
==========================
initializing...
cleaning...
patching 'highmem.h'...
skipping patch for 'drmP.h', not needed
skipping patch for 'drm_os_linux.h', not needed
assuming new VMA API since we do have kernel 2.6.x...
doing Makefile based build for kernel 2.6.x and higher
make -C /lib/modules/2.6.6-mm3/build
SUBDIRS=/lib/modules/fglrx/build_mod/2.6.x modules
make[1]: Entering directory `/usr/src/linux-2.6.6'
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agp3.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/nvidia-agp.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agpgart_be.o
/lib/modules/fglrx/build_mod/2.6.x/agpgart_be.c: In function
`agp_generic_alloc_page':
/lib/modules/fglrx/build_mod/2.6.x/agpgart_be.c:1405: error: structure
has no member named `count'
/lib/modules/fglrx/build_mod/2.6.x/agpgart_be.c: In function `ali_alloc_page':
/lib/modules/fglrx/build_mod/2.6.x/agpgart_be.c:4416: error: structure
has no member named `count'
make[2]: *** [/lib/modules/fglrx/build_mod/2.6.x/agpgart_be.o] Error 1
make[1]: *** [/lib/modules/fglrx/build_mod/2.6.x] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.6'
make: *** [kmod_build] Error 2
build failed with return value 2

  
Helpme please,

Any idea.
