Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTJDPGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbTJDPGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 11:06:50 -0400
Received: from mail.g-housing.de ([62.75.136.201]:34220 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261298AbTJDPGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 11:06:48 -0400
Message-ID: <3F7EE203.4030601@g-house.de>
Date: Sat, 04 Oct 2003 17:06:43 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031002
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: compile error with 2.6.0-test6 on ppc32
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

upon compiling kernel 2.6.0-test6 on my PowerPC 604r machine (PReP),
i got the following error:


evil@sheep:/usr/src/linux-2.6$ make bzImage modules
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
   KSYM    .tmp_kallsyms1.S
   AS      .tmp_kallsyms1.o
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
   AS      arch/ppc/boot/common//util.o
arch/ppc/boot/common/util.S: Assembler messages:
arch/ppc/boot/common/util.S:220: Warning: setting incorrect section 
attributes for .relocate_code
arch/ppc/boot/common//util.o: File truncated
arch/ppc/boot/common/util.S:281: FATAL: Can't write 
arch/ppc/boot/common//util.o: File truncated
make[2]: *** [arch/ppc/boot/common//util.o] Error 1
make[1]: *** [arch/ppc/boot/common/] Error 2
make: *** [zImage] Error 2
evil@sheep:/usr/src/linux-2.6$ cp .config ~/



(the compile-process was about to finish last time, then i got this very
same error, but could not save it. now calling "make bzImage" has a very 
less to re-compile, hence the few messages. oh, yes: i *do* have write 
permission to [arch/ppc/boot/common//util.o] )

i tried with:

gcc (GCC) 3.3.2 20030908 (Debian prerelease)
GNU ld version 2.14.90.0.6 20030820 Debian GNU/Linux
GNU Make 3.80

distribution is Debian GNU/Linux (unstable)

my config is on:

http://www.nerdbynature.de/bits/ppc/.config

i can compile 2.4 kernels very well with the same utils.

Thank you,
Christian.
-- 
BOFH excuse #442:

Trojan horse ran out of hay

