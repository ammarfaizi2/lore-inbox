Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKCOPQ>; Sun, 3 Nov 2002 09:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSKCOPQ>; Sun, 3 Nov 2002 09:15:16 -0500
Received: from mail01.solnet.ch ([212.101.4.135]:7685 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id <S261900AbSKCOPN>;
	Sun, 3 Nov 2002 09:15:13 -0500
Message-ID: <3DC530F9.7030500@solnet.ch>
Date: Sun, 03 Nov 2002 15:21:45 +0100
From: Abhishek Khurana <abhikhurana@solnet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems compiling kernel 2.5.45
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am running a mandrake 9.0 system with kernel 2.4.20, and I tried
compiling the kernel 2.5.45. And I had some problems, which look like
some bugs.
While compiling the ATI Radeon driver I get the messages
rivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1578: structure has no member named `line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named `line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named `line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named `line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared
`static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but
not used
make[3]: *** [drivers/video/radeonfb.o] Error 1
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make: *** [vmlinux] Error 2
Looking at the code, it seems that indeed the struct display has been
changed in 2.5.45 but radeonfb.c still refers to non existent members of
that struct.
After putting in the old driver in its place I moved on and I got the 
following error
messages in nfs

nclude/linux/intermezzo_fs.h:30:34: linux/intermezzo_lib.h: No such file
or directory
include/linux/intermezzo_fs.h:31:34: linux/intermezzo_idl.h: No such
file or directory
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:49: field `remote_version' has incomplete type
include/linux/intermezzo_fs.h:52: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:52: warning: its scope is only this
definition or declaration, which is probably not what you want
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:399: field `fd_version' has incomplete type
include/linux/intermezzo_fs.h:645: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:648: warning: `struct izo_upcall_hdr'
declared inside parameter list
include/linux/intermezzo_fs.h:652: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:654: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:655: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h: In function `izo_ioctl_getdata':
include/linux/intermezzo_fs.h:727: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:733: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:733: `IZO_IOCTL_VERSION' undeclared (first
use in this function)
include/linux/intermezzo_fs.h:733: (Each undeclared identifier is
reported only once
include/linux/intermezzo_fs.h:733: for each function it appears in.)
include/linux/intermezzo_fs.h:738: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:743: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:743: sizeof applied to an incomplete type
include/linux/intermezzo_fs.h:748: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:754: warning: passing arg 1 of
`izo_ioctl_is_invalid' from incompatible pointer type
include/linux/intermezzo_fs.h:759: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:760: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:760: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:763: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:764: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:764: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:765: warning: implicit declaration of
function `size_round'
include/linux/intermezzo_fs.h:765: dereferencing pointer to incomplete type
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:777: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:778: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:779: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:862: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h: In function `izo_ioctl_packlen':
include/linux/intermezzo_fs.h:864: sizeof applied to an incomplete type
include/linux/intermezzo_fs.h:865: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:866: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:870: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:871: conflicting types for
`izo_ioctl_is_invalid'
include/linux/intermezzo_fs.h:52: previous declaration of
`izo_ioctl_is_invalid'
include/linux/intermezzo_fs.h: In function `izo_ioctl_is_invalid':
include/linux/intermezzo_fs.h:872: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:876: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:880: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:900: warning: passing arg 1 of
`izo_ioctl_packlen' from incompatible pointer type
include/linux/intermezzo_fs.h:900: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:904: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:909: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete type
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:919: warning: `struct kml_rec' declared
inside parameter list
include/linux/intermezzo_fs.h:920: warning: `struct kml_rec' declared
inside parameter list
make[2]: *** [fs/intermezzo/cache.o] Error 1
make[1]: *** [fs/intermezzo] Error 2

Again, looking at the sources, it lookes like a genuine error and not a
configuration problem.
So I removed this module and when I compiled again I got the error


  gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=pentium4 -Iarch/i386/mach-generic -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
net/ipv4/ipmr.c: In function `ipmr_forward_finish':
net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
net/ipv4/ipmr.c:1170: structure has no member named `pmtu'
make[2]: *** [net/ipv4/ipmr.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2
and I could see that pmtu was a member in 2.4.20 but not in 2.5.45.

I am kinda new to compiling and configuring kernels and feel much more
comfortable writing drivers and stacks for RTOSes. So is there anything
obvious I have missed?? Or is it normal with pre-release kernels? 
Besides i saw a lot of warning messages. Again, is that normal? I mean 
normally one expects that when a person is changing something in a file, 
its his/her responsibility to ensure that no warnings are generated with 
-wall, isn't it so?


Abhishek


