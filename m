Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270649AbRHSRM0>; Sun, 19 Aug 2001 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270648AbRHSRMP>; Sun, 19 Aug 2001 13:12:15 -0400
Received: from dorthy.state.net ([204.75.238.244]:27600 "EHLO state.net")
	by vger.kernel.org with ESMTP id <S270647AbRHSRMG>;
	Sun, 19 Aug 2001 13:12:06 -0400
Date: Sun, 19 Aug 2001 12:13:52 -0500 (CDT)
From: Chris Oxenreider <oxenreid@state.net>
Reply-To: oxenreid@state.net
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.9 build fails on Mandrake 8.0
Message-ID: <Pine.SV4.4.10.10108191150090.1226-100000@dorthy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Help.
On a freshly installed system using a version of Mandrake 8.0 from the 
free 'iso' images on the linux-mandrake sight this is what happens:


cd /usr/src
# remove the link in /usr/src
rm linux
bzip2 -dc /tmp/linux-2.4.9.tar.bz2|tar xvf - 
chown -R root.root linux
mv linux linux-2.4.9
ln -s linux-2.4.9 linux
cd linux-2.4.9
cp /boot/config-2.4.3-20mdk .config
echo Take default answers to all:
make oldconfig 
make dep ; echo made Dependancies && \
make clean ; echo made clean && \
make bzImage ; echo made bzImage && \
make modules 

when compiling modules this error is generated:

---Lots of other compiler messages---
make -C ntfs modules
make[2]: Entering directory `/usr/src/linux-2.4.9/fs/ntfs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.9/include/linux/modversions.h -DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/fs'
make: *** [_mod_fs] Error 2
[root@odin linux-2.4.9]# 



