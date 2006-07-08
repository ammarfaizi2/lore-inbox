Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWGHUUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWGHUUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGHUUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:20:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030326AbWGHUUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:20:11 -0400
Date: Sat, 8 Jul 2006 22:20:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Kirill Korotaev <dev@openvz.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm6: kernel/sysctl.c: PROC_FS=n compile error
Message-ID: <20060708202011.GD5020@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

namespaces-utsname-sysctl-hack.patch and ipc-namespace-sysctls.patch 
cause the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      kernel/sysctl.o
kernel/sysctl.c:107: warning: #proc_do_ipc_string# used but never defined
kernel/sysctl.c:150: warning: #proc_do_utsns_string# used but never defined
kernel/sysctl.c:2465: warning: #proc_do_uts_string# defined but not used
...
  LD      .tmp_vmlinux1
kernel/built-in.o:(.data+0x938): undefined reference to `proc_do_utsns_string'
kernel/built-in.o:(.data+0x964): undefined reference to `proc_do_utsns_string'
kernel/built-in.o:(.data+0x990): undefined reference to `proc_do_utsns_string'
kernel/built-in.o:(.data+0x9bc): undefined reference to `proc_do_utsns_string'
kernel/built-in.o:(.data+0x9e8): undefined reference to `proc_do_utsns_string'
kernel/built-in.o:(.data+0xc24): undefined reference to `proc_do_ipc_string'
kernel/built-in.o:(.data+0xc50): undefined reference to `proc_do_ipc_string'
kernel/built-in.o:(.data+0xc7c): undefined reference to `proc_do_ipc_string'
kernel/built-in.o:(.data+0xca8): undefined reference to `proc_do_ipc_string'
kernel/built-in.o:(.data+0xcd4): undefined reference to `proc_do_ipc_string'
kernel/built-in.o:(.data+0xd00): more undefined references to `proc_do_ipc_string' follow
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

