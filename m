Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTKVMsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTKVMsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 07:48:05 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:13682 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262228AbTKVMsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 07:48:02 -0500
Message-ID: <3FBF5C79.5050409@wanadoo.fr>
Date: Sat, 22 Nov 2003 13:54:17 +0100
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test9-mm5 : compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any idea about this error?

  CC      lib/rwsem.o
  CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  LD      arch/i386/lib/built-in.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/iodebug.o
  CC      arch/i386/lib/kgdb_serial.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/oprofile/built-in.o: In function `oprofile_reset_stats':
/usr/src/mm/include/asm/bitops.h:251: undefined reference to 
`cpu_possible_map'
arch/i386/oprofile/built-in.o: In function `oprofile_create_stats_files':
/usr/src/mm/include/asm/bitops.h:251: undefined reference to 
`cpu_possible_map'
make: *** [.tmp_vmlinux1] Error 1

grep SMP .config
CONFIG_BROKEN_ON_SMP=y
# CONFIG_X86_BIGSMP is not set
CONFIG_SMP=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_SMP=y

grep OPROFILE .config
CONFIG_OPROFILE=y

Remi


