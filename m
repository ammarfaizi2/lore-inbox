Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVEXEDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVEXEDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 00:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXEDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 00:03:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31436 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261216AbVEXEDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 00:03:32 -0400
Message-ID: <4292A78C.4070600@pobox.com>
Date: Tue, 24 May 2005 00:03:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corey Minyard <minyard@mvista.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: IPMI breaks 'make all{yes|mod}config'
Content-Type: multipart/mixed;
 boundary="------------020507090404070903060208"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507090404070903060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Everything else seems to build, here on x86 32-bit all{yes|mod}config, 
except IPMI.  See attached build log for output.

	Jeff




--------------020507090404070903060208
Content-Type: text/plain;
 name="build.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build.txt"

  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  AS      arch/i386/kernel/vsyscall-note.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
  AS      arch/i386/kernel/vsyscall.o
  SYSCALL arch/i386/kernel/vsyscall-syms.o
  LD      arch/i386/kernel/built-in.o
  CC      drivers/char/ipmi/ipmi_devintf.o
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of `class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of `class_simple_device_remove' makes integer from pointer without a cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to function `class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function `init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1
make[2]: *** [drivers/char/ipmi] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

--------------020507090404070903060208--
