Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSBNImL>; Thu, 14 Feb 2002 03:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSBNImC>; Thu, 14 Feb 2002 03:42:02 -0500
Received: from ns.tasking.nl ([195.193.207.2]:45831 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S287966AbSBNIlx>;
	Thu, 14 Feb 2002 03:41:53 -0500
Date: Thu, 14 Feb 2002 09:39:55 +0100
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Oops
Message-ID: <20020214093955.A28603@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.5 on i686 2.4.17-x67.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-x67/ (default)
     -m /boot/System.map-2.4.17-x67 (specified)

Feb 14 09:35:01 espoo kernel: Unable to handle kernel paging request at virtual address 0000ffff 
Feb 14 09:35:01 espoo kernel: c0140de0 
Feb 14 09:35:01 espoo kernel: *pde = 00000000 
Feb 14 09:35:01 espoo kernel: Oops: 0000 
Feb 14 09:35:01 espoo kernel: CPU:    0 
Feb 14 09:35:01 espoo kernel: EIP:    0010:[<c0140de0>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 14 09:35:01 espoo kernel: EFLAGS: 00010207 
Feb 14 09:35:01 espoo kernel: eax: c1471600   ebx: 0000ffef   ecx: 0000000f   edx: c1440000 
Feb 14 09:35:01 espoo kernel: esi: 0028c69d   edi: c9baff74   ebp: 0000ffff   esp: c9baff10 
Feb 14 09:35:01 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Feb 14 09:35:01 espoo kernel: Process distribute (pid: 28497, stackpage=c9baf000) 
Feb 14 09:35:01 espoo kernel: Stack: 0028c69d ce252adc c9baff74 c9baffa4 c1471600 cd014014 0028c69d 00000003  
Feb 14 09:35:01 espoo kernel:        c0138d04 ce252adc c9baff74 0028c69d c013942a ce252adc c9baff74 00000000  
Feb 14 09:35:01 espoo kernel:        cd014000 00000000 c9baffa4 00000009 c9bae000 c9bae000 00000009 cd014017  
Feb 14 09:35:01 espoo kernel: Call Trace: [<c0138d04>] [<c013942a>] [<c013969a>] [<c0139a51>] [<c0136869>]  
Feb 14 09:35:01 espoo kernel:    [<c0106db3>]  
Feb 14 09:35:01 espoo kernel: Code: 8b 6d 00 8b 74 24 18 39 73 44 75 7c 8b 74 24 24 39 73 0c 75  

>>EIP; c0140de0 <d_lookup+60/100>   <=====
Trace; c0138d04 <cached_lookup+10/54>
Trace; c013942a <link_path_walk+522/778>
Trace; c013969a <path_walk+1a/1c>
Trace; c0139a51 <__user_walk+35/50>
Trace; c0136869 <sys_newstat+19/70>
Trace; c0106db3 <system_call+33/40>
Code;  c0140de0 <d_lookup+60/100>
00000000 <_EIP>:
Code;  c0140de0 <d_lookup+60/100>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c0140de3 <d_lookup+63/100>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c0140de7 <d_lookup+67/100>
   7:   39 73 44                  cmpl   %esi,0x44(%ebx)
Code;  c0140dea <d_lookup+6a/100>
   a:   75 7c                     jne    88 <_EIP+0x88> c0140e68 <d_lookup+e8/100>
Code;  c0140dec <d_lookup+6c/100>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c0140df0 <d_lookup+70/100>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c0140df3 <d_lookup+73/100>
  13:   75 00                     jne    15 <_EIP+0x15> c0140df5 <d_lookup+75/100>

-- 
Frank
