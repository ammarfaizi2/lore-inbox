Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUITI0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUITI0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUITI0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 04:26:24 -0400
Received: from relay.pair.com ([209.68.1.20]:5130 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262085AbUITI0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 04:26:22 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <414E93BC.4080107@kegel.com>
Date: Mon, 20 Sep 2004 01:24:28 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8 link failure for powerpc-970?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to verify that I can build toolchains and compile
and link kernels for a large set of CPU types using simple kernel config files.
I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
So any problems I run into are a bit hard to pin down to
compiler, kernel, or user error, since this is mostly new territory for me.

Here's one issue.
When I build 2.6.8 for powerpc-970 (using the config file
I got when I ran 'make allnoconfig' on 2.6.5; you can see it at
http://kegel.com/crosstool/crosstool-0.28-rc36/powerpc64.config),
I get a few link errors:

arch/ppc64/kernel/built-in.o(.text+0xdc44): In function `.sys32_ipc':
: undefined reference to `.compat_sys_shmctl'
arch/ppc64/kernel/built-in.o(.text+0xdca0): In function `.sys32_ipc':
: undefined reference to `.compat_sys_semctl'
arch/ppc64/kernel/built-in.o(.text+0xdcbc): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgsnd'
arch/ppc64/kernel/built-in.o(.text+0xdce0): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgrcv'
arch/ppc64/kernel/built-in.o(.text+0xdd0c): In function `.sys32_ipc':
: undefined reference to `.compat_sys_msgctl'
arch/ppc64/kernel/built-in.o(.text+0xdd28): In function `.sys32_ipc':
: undefined reference to `.compat_sys_shmat'
arch/ppc64/kernel/built-in.o(.text+0xdd3c): In function `.sys32_ipc':
: undefined reference to `.compat_sys_semtimedop'
arch/ppc64/kernel/built-in.o(.text+0xe9d4): In function `.sys32_sysctl':
: undefined reference to `.do_sysctl'
arch/ppc64/kernel/built-in.o(.text+0x10958): In function `.routing_ioctl':
: undefined reference to `.sockfd_lookup'
net/built-in.o(.text+0x278): In function `.verify_compat_iovec':
: undefined reference to `.move_addr_to_kernel'
net/built-in.o(.text+0x724): In function `.scm_detach_fds_compat':
: undefined reference to `.__scm_destroy'
make: *** [.tmp_vmlinux1] Error 1

Is this user error for using an old config file, is it silliness
from gcc-3.4.2, or is something else going on?

Thanks,
Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
