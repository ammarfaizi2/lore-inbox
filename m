Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVDHM6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVDHM6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVDHM6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:58:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:44743 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262790AbVDHM6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:58:42 -0400
Message-ID: <42568000.9090400@gmx.net>
Date: Fri, 08 Apr 2005 14:58:40 +0200
From: Wotan23 <robert-maillist@gmx.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linker error lib/lib.a (lib/string.c)
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:a6d64f00942060a8b48ccf3803478cad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when i compile the 2.6.12-rc2-mm1 on a ppc with "make all" i got for line:

ld -m elf32ppc -o arch/ppc/boot/openfirmware/coffboot -T
/usr/src/linux-2.6.12-rc2-mm1/arch/ppc/boot/ld.script -e _start -Ttext
0x00500000 -Bstatic arch/ppc/boot/openfirmware/coffcrt0.o
arch/ppc/boot/openfirmware/start.o arch/ppc/boot/openfirmware/misc.o
arch/ppc/boot/openfirmware/common.o
arch/ppc/boot/openfirmware/coffmain.o arch/ppc/boot/openfirmware/image.o
lib/lib.a arch/ppc/boot/lib/lib.a arch/ppc/boot/of1275/lib.a
arch/ppc/boot/common/lib.a && objcopy
arch/ppc/boot/openfirmware/coffboot arch/ppc/boot/openfirmware/coffboot
-R .comment

the output :

lib/lib.a(string.o)(.text+0x57c): In function `kstrdup':
: undefined reference to `__kmalloc'
objcopy: 'arch/ppc/boot/openfirmware/coffboot': No such file
make[2]: *** [arch/ppc/boot/images/vmlinux.coff] Error 1
make[1]: *** [openfirmware] Error 2
make: *** [zImage] Error 2

it seem that :

+create-a-kstrdup-library-function.patch
+create-a-kstrdup-library-function-fixes.patch
 kstrdup().

is responsible for that.

Thx

