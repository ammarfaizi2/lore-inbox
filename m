Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGFSqF>; Sat, 6 Jul 2002 14:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGFSqE>; Sat, 6 Jul 2002 14:46:04 -0400
Received: from [213.4.129.129] ([213.4.129.129]:36699 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S315762AbSGFSqD>;
	Sat, 6 Jul 2002 14:46:03 -0400
Date: Sat, 6 Jul 2002 20:40:36 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFree + "stonerview" screensaver -> Xfree oops
Message-Id: <20020706204036.7582c612.diegocg@teleline.es>
In-Reply-To: <20020705170823.1b5551c7.diegocg@teleline.es>
References: <20020705170823.1b5551c7.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002 17:08:23 +0200
Diego Calleja <diegocg@teleline.es> escribió:

Jul  5 16:33:36 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001c 
Jul  5 16:33:36 localhost kernel: c01b41aa 
Jul  5 16:33:36 localhost kernel: *pde = 00a63067
Jul  5 16:33:36 localhost kernel: Oops: 0000
Jul  5 16:33:36 localhost kernel: CPU:    0
Jul  5 16:33:36 localhost kernel: EIP:    0010:[sock_poll+30/40]    Not tainted 
Jul  5 16:33:36 localhost kernel: EFLAGS: 00210282
Jul  5 16:33:36 localhost kernel: eax: 00000000   ebx: c0b4db20   ecx: 00000000   edx: c1bd35b4 
Jul  5 16:33:36 localhost kernel: esi: c0b4db20   edi: 00000000   ebp: c1845f70   esp: c1845f28 
Jul  5 16:33:36 localhost kernel: ds: 0018   es: 0018   ss: 0018 
Jul  5 16:33:36 localhost kernel: Process XFree86 (pid: 310, stackpage=c1845000) 
Jul  5 16:33:36 localhost kernel: Stack: c0b4db20 c1bd35b4 00000000 00000000 c013e1d6 c0b4db20 00000000 00000100 
Jul  5 16:33:36 localhost kernel:        00000020 c11fff20 00000145 00080000 c1844000 7fffffff 00000013 00000000 
Jul  5 16:33:36 localhost kernel:        00000000 c149d000 00000000 c013e62c 00000017 c1845fa8 c1845fa4 c1844000 
Jul  5 16:33:36 localhost kernel: Call Trace: [do_select+226/476] [sys_select+820/1156] [system_call+51/64] 
Jul  5 16:33:36 localhost kernel: Code: 8b 40 1c ff d0 83 c4 0c 5b c3 53 8b 5c 24 08 8b 43 08 8b 54 
Using defaults from ksymoops -t elf32-i386 -a i386


> 
> 
> >>ebx; c0b4db20 <[apm].bss.end+137801/2cdce1>
> >>edx; c1bd35b4 <[sb].bss.end+9ab8d5/bf0321>
> >>esi; c0b4db20 <[apm].bss.end+137801/2cdce1>
> >>ebp; c1845f70 <[sb].bss.end+61e291/bf0321>
> >>esp; c1845f28 <[sb].bss.end+61e249/bf0321>
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 40 1c                  mov    0x1c(%eax),%eax
> Code;  00000003 Before first symbol
>    3:   ff d0                     call   *%eax
> Code;  00000005 Before first symbol
>    5:   83 c4 0c                  add    $0xc,%esp
> Code;  00000008 Before first symbol
>    8:   5b                        pop    %ebx
> Code;  00000009 Before first symbol
>    9:   c3                        ret    
> Code;  0000000a Before first symbol
>    a:   53                        push   %ebx
> Code;  0000000b Before first symbol
>    b:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
> Code;  0000000f Before first symbol
>    f:   8b 43 08                  mov    0x8(%ebx),%eax
> Code;  00000012 Before first symbol
>   12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx
> 
> 
> 1 warning issued.  Results may not be reliable.
> 
> -----------------------------------------------------------------------
> ----------
> 
> -When i watch the stopped screen, the image _always_ is the same, the
> screensaver always stops at the same point Any advices of how to
> debug/strace/whatever this?
> 
> (after Xfree is hanged, ctrl+alt+Fn does'nt works, so i do sysrq sync +
> reboot, but this is normal...)
> 
> 
> Regards, Diego Calleja
> 
> 
