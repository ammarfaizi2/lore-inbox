Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283167AbRK2KuC>; Thu, 29 Nov 2001 05:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283176AbRK2Ktx>; Thu, 29 Nov 2001 05:49:53 -0500
Received: from web13604.mail.yahoo.com ([216.136.175.115]:7692 "HELO
	web13604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283167AbRK2Kth>; Thu, 29 Nov 2001 05:49:37 -0500
Message-ID: <20011129104936.66773.qmail@web13604.mail.yahoo.com>
Date: Thu, 29 Nov 2001 02:49:36 -0800 (PST)
From: Todd Roy <todd_m_roy@yahoo.com>
Subject: lvm.c compilation errors with 2.5.1-pre2 and pre3
To: linux-kernel@vger.kernel.org
Cc: linux-lvm@sistina.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I got these errors trying to
compile 2.5.1-pre2 and pre3:

make[3]: Entering directory
`/usr/src/linux-2.5/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4     -c -o lvm.o lvm.c
lvm.c: In function `lvm_user_bmap':
lvm.c:1046: request for member `bv_len' in something
not a structure or union
lvm.c: In function `lvm_map':
lvm.c:1249: `BIO_HASHED' undeclared (first use in this
function)
lvm.c:1249: (Each undeclared identifier is reported
only once
lvm.c:1249: for each function it appears in.)
make[3]: *** [lvm.o] Error 1
make[3]: Leaving directory
`/usr/src/linux-2.5/drivers/md'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/src/linux-2.5/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.5/drivers'
make: *** [_dir_drivers] Error 2
[supermoby] /usr/src/linux-2.5
root $ more Makefile

Looks like BIO_HASHED was left in from somewhere... I
can't find a definition for it anywhere.

-- todd --

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
