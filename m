Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSEIPIc>; Thu, 9 May 2002 11:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSEIPIb>; Thu, 9 May 2002 11:08:31 -0400
Received: from WARSL402PIP7.highway.telekom.at ([195.3.96.94]:16476 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S313421AbSEIPIa>;
	Thu, 9 May 2002 11:08:30 -0400
Date: Thu, 9 May 2002 17:09:35 +0200
From: byonic@gmx.net
X-Mailer: The Bat! (v1.48f) Personal
Reply-To: byonic@gmx.net
X-Priority: 3 (Normal)
Message-ID: <69165797043.20020509170935@gmx.net>
To: linux-kernel@vger.kernel.org
CC: byonic@gmx.net
Subject: Problem with kdb kernel debugger patch against 2.2.19
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel@vger.kernel.org,

  I patched my 2.2.19 kernel with the SGI kdb patch to have the
  ability of kernel debugging and especially debugging of the kernel
  modules I write.
  I had to install libbfd and the kernel seems just to compile perfectly.
  Lateron I get the following error :

  /usr/src/linux # make bzImage

  [...]
  
make[2]: Entering directory `/usr/src/kernel-source-2.2.19/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/kernel-source-2.2.19/lib'
make[1]: Leaving directory `/usr/src/kernel-source-2.2.19/lib'
make -C  arch/i386/kernel
make[1]: Entering directory `/usr/src/kernel-source-2.2.19/arch/i386/kernel'
cc -D__KERNEL__ -I/usr/src/linux/include -D__ASSEMBLY__  -traditional -c entry.S -o entry.o
/tmp/ccVx3zpC.s: Assembler messages:
/tmp/ccVx3zpC.s:774: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:774: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:805: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:805: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:824: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:824: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:920: Warning: using `%ecx' instead of `%cx' due to `l' suffix
/tmp/ccVx3zpC.s:929: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:930: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:943: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:943: Warning: using `%edx' instead of `%dx' due to `l' suffix
/tmp/ccVx3zpC.s:1024: Fatal error: Symbol machine_check already defined.
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory `/usr/src/kernel-source-2.2.19/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

   What does
   "/tmp/ccVx3zpC.s:1024: Fatal error: Symbol machine_check already
   defined." mean, how can I solve it to get my kernel with kdb ?

   Note: I'm still using 2.2.19 because of module development to test
   kernel modules for 2.2.x.

   Thanks in advance, Markus

-- 
Best regards,
 byonic                          mailto:byonic@gmx.net


