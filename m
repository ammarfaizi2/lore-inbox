Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270721AbRHSThi>; Sun, 19 Aug 2001 15:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270727AbRHSTh2>; Sun, 19 Aug 2001 15:37:28 -0400
Received: from dorthy.state.net ([204.75.238.244]:24787 "EHLO state.net")
	by vger.kernel.org with ESMTP id <S270721AbRHSThM>;
	Sun, 19 Aug 2001 15:37:12 -0400
Date: Sun, 19 Aug 2001 14:38:58 -0500 (CDT)
From: Chris Oxenreider <oxenreid@state.net>
Reply-To: oxenreid@state.net
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install
 'isdn')
Message-ID: <Pine.SV4.4.10.10108191436230.4651-100000@dorthy>
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
make modules_install

when installing modules this error is generated:

---Lots of other compiler messages---
make[1]: Leaving directory `/usr/src/linux-2.4.9/arch/i386/lib'
cd /lib/modules/2.4.9; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.9; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.9/kernel/drivers/isdn/eicon/divas.o
depmod: 	vsnprintf
depmod: *** Unresolved symbols in
/lib/modules/2.4.9/kernel/drivers/isdn/eicon/eicon.o
depmod: 	vsnprintf
[root@odin linux-2.4.9]#



