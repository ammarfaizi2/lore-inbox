Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287461AbRLaFzU>; Mon, 31 Dec 2001 00:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287465AbRLaFzK>; Mon, 31 Dec 2001 00:55:10 -0500
Received: from mail205.mail.bellsouth.net ([205.152.58.145]:26869 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S287461AbRLaFy4>; Mon, 31 Dec 2001 00:54:56 -0500
Message-ID: <3C2FFDA8.81073B84@bellsouth.net>
Date: Mon, 31 Dec 2001 00:54:48 -0500
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.12 is available
In-Reply-To: <25851.1009710091@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, 28 Dec 2001 13:31:42 +1100,
> Keith Owens <kaos@ocs.com.au> wrote:
> >This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.

> 
> http://sourceforge.net/project/showfiles.php?group_id=18813
> Release 1.12.
> 

Is it just me or did 1.12 break i386 in 2.4.18-pre1?
I applied linux-2.4.18-pre1 then:
kbuild-2.5-2.4.16-3                
kbuild-2.5-2.4.17-1
kbuild-2.5-2.4.18-pre1-1
cp /tmp/saved.config /usr/src/linux/.config

I noticed there is no link include/asm to include/asm-i386

Here is my output:
home1:~/linux# ll .config*
  28 -rw-r--r--   1 root     root        25907 Dec 31 00:04 .config
home1:~/linux# make -f Makefile-2.5 oldconfig
In file included from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from /usr/src/linux/scripts/pp_makefile.h:11,
                 from /usr/src/linux/scripts/pp_filetree.c:11:
/usr/include/linux/errno.h:4: asm/errno.h: No such file or directory
make: *** [/usr/src/linux/scripts/pp_filetree.o] Error 1
home1:~/linux# cat .tmp_KERNELRELEASE
KERNELRELEASE=2.4.18pre1

Work around is to perform "make oldconfig" then
copy saved.config to /usr/src/linux.  Now
make -f Makefile-2.5 oldconfig works as well as everything
else.

Any thoughts?
Later,
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

