Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWHTQEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWHTQEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWHTQEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:04:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:13539 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750828AbWHTQEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:04:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SETkgfmkvU9zf1QFH4tYABIhN32cwm5vShp2sRA/IPl9Ztcs4ylhHYi0PVnQYFksJfZH61WReaOdm+kPuda+2BVs8DYwqR17jUFz30tigxHY38wGFq1BdkGPKulxAGY4sfBLK1R6T/qFFQp1Qh2J7l9uAS97/Jd7uOnLb6HCz2k=
Message-ID: <44E88821.8080001@gmail.com>
Date: Sun, 20 Aug 2006 18:04:49 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc4-mm2
References: <20060819220008.843d2f64.akpm@osdl.org>
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> 

System hangs on this

Aug 20 17:47:47 euridica kernel: BUG: MAX_STACK_TRACE_ENTRIES too low!
Aug 20 17:47:47 euridica kernel: turning off the locking correctness validator.
Aug 20 17:47:47 euridica kernel:  [<c01041b5>] dump_trace+0x64/0x1b2
Aug 20 17:47:47 euridica kernel:  [<c0104315>] show_trace_log_lvl+0x12/0x25
Aug 20 17:47:47 euridica kernel:  [<c0104985>] show_trace+0xd/0x10
Aug 20 17:47:47 euridica kernel:  [<c0104a4d>] dump_stack+0x19/0x1b
Aug 20 17:47:47 euridica kernel:  [<c013878b>] save_trace+0xd0/0xdd
Aug 20 17:47:47 euridica kernel:  [<c01387f4>] add_lock_to_list+0x5c/0x7a
Aug 20 17:47:47 euridica kernel:  [<c013a93d>] __lock_acquire+0x9f3/0xaef
Aug 20 17:47:47 euridica kernel:  [<c013ada3>] lock_acquire+0x71/0x91
Aug 20 17:47:47 euridica kernel:  [<c02f87b9>] _spin_lock_irqsave+0x2c/0x3c
Aug 20 17:47:47 euridica kernel:  [<c01d2b8a>] avc_has_perm_noaudit+0x23b/0x487
Aug 20 17:47:47 euridica kernel:  [<c01d3a5c>] avc_has_perm+0x22/0x45
Aug 20 17:47:48 euridica kernel:  [<c01d3d58>] ipc_has_perm+0x58/0x60
Aug 20 17:47:48 euridica kernel:  [<c01d3d96>] selinux_ipc_permission+0x36/0x39
Aug 20 17:47:48 euridica kernel:  [<c01c7ad6>] ipcperms+0xd7/0xe0
Aug 20 17:47:48 euridica kernel:  [<c01ca6c0>] do_shmat+0x29b/0x2b2
Aug 20 17:47:49 euridica kernel:  [<c0107c96>] sys_ipc+0xe8/0x143
Aug 20 17:47:49 euridica kernel:  [<c01031b5>] sysenter_past_esp+0x56/0x8d
Aug 20 17:47:49 euridica kernel: DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Aug 20 17:47:49 euridica kernel:
Aug 20 17:47:49 euridica kernel: Leftover inexact backtrace:
Aug 20 17:47:49 euridica kernel:
Aug 20 17:47:50 euridica kernel:  [<c0104315>] show_trace_log_lvl+0x12/0x25
Aug 20 17:47:50 euridica kernel:  [<c0104985>] show_trace+0xd/0x10
Aug 20 17:47:50 euridica kernel:  [<c0104a4d>] dump_stack+0x19/0x1b
Aug 20 17:47:50 euridica kernel:  [<c013878b>] save_trace+0xd0/0xdd
Aug 20 17:47:50 euridica kernel:  [<c01387f4>] add_lock_to_list+0x5c/0x7a
Aug 20 17:47:50 euridica kernel:  [<c013a93d>] __lock_acquire+0x9f3/0xaef
Aug 20 17:47:50 euridica kernel:  [<c013ada3>] lock_acquire+0x71/0x91
Aug 20 17:47:50 euridica kernel:  [<c02f87b9>] _spin_lock_irqsave+0x2c/0x3c
Aug 20 17:47:50 euridica kernel:  [<c01d2b8a>] avc_has_perm_noaudit+0x23b/0x487
Aug 20 17:47:51 euridica kernel:  [<c01d3a5c>] avc_has_perm+0x22/0x45
Aug 20 17:47:51 euridica kernel:  [<c01d3d58>] ipc_has_perm+0x58/0x60
Aug 20 17:47:51 euridica kernel:  [<c01d3d96>] selinux_ipc_permission+0x36/0x39
Aug 20 17:47:52 euridica kernel:  [<c01c7ad6>] ipcperms+0xd7/0xe0

When I build kernel with gcc 3.4.6 everything works fine.

gcc-3.4 -v
Reading specs from /usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
Configured with: ./configure --prefix=/usr/local/ --disable-nls --enable-shared --enable-languages=c --program-suffix=-3.4
Thread model: posix
gcc version 3.4.6

gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --with-cpu=generic --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)

Here is a config file http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

