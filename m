Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRBKOnK>; Sun, 11 Feb 2001 09:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBKOnB>; Sun, 11 Feb 2001 09:43:01 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:19718 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129529AbRBKOm6>; Sun, 11 Feb 2001 09:42:58 -0500
Date: Sun, 11 Feb 2001 15:42:53 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: OOPS with 2.4.1-ac8
Message-ID: <20010211154253.A484@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii

I suddenly started to get those oopses.  It didn't seem to cause
any problems tho.

I hope this result from ksymoops are usefull.


Kurt


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.3.7 on i586 2.4.1-ac8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac8/ (default)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb 11 15:04:01 Q kernel: c013d4a6 
Feb 11 15:04:01 Q kernel: Oops: 0000 
Feb 11 15:04:01 Q kernel: CPU:    0 
Feb 11 15:04:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:04:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:04:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:04:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c1437f04 
Feb 11 15:04:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:04:01 Q kernel: Process sh (pid: 13077, stackpage=c1437000) 
Feb 11 15:04:01 Q kernel: Stack: c1437f68 00000000 c3fca320 c1437fa4 c3fe8dc8 c2957005 00704020 00000005  
Feb 11 15:04:01 Q kernel:        c01359f2 c3fca320 c1437f68 c1437f68 c0136161 c3fca320 c1437f68 00000000  
Feb 11 15:04:01 Q kernel:        c2957000 00000000 c1437fa4 080b91c4 c2957000 080b91c4 c013581b 00000009  
Feb 11 15:04:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:04:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:05:01 Q kernel: c013d4a6 
Feb 11 15:05:01 Q kernel: Oops: 0000 
Feb 11 15:05:01 Q kernel: CPU:    0 
Feb 11 15:05:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:05:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:05:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:05:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c1437f04 
Feb 11 15:05:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:05:01 Q kernel: Process sh (pid: 13079, stackpage=c1437000) 
Feb 11 15:05:01 Q kernel: Stack: c1437f68 00000000 c3fca320 c1437fa4 c3fe8dc8 c2c41005 00704020 00000005  
Feb 11 15:05:01 Q kernel:        c01359f2 c3fca320 c1437f68 c1437f68 c0136161 c3fca320 c1437f68 00000000  
Feb 11 15:05:01 Q kernel:        c2c41000 00000000 c1437fa4 080b91c4 c2c41000 080b91c4 c013581b 00000009  
Feb 11 15:05:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:05:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:06:01 Q kernel: c013d4a6 
Feb 11 15:06:01 Q kernel: Oops: 0000 
Feb 11 15:06:01 Q kernel: CPU:    0 
Feb 11 15:06:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:06:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:06:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:06:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c1437f04 
Feb 11 15:06:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:06:01 Q kernel: Process sh (pid: 13081, stackpage=c1437000) 
Feb 11 15:06:01 Q kernel: Stack: c1437f68 00000000 c3fca320 c1437fa4 c3fe8dc8 c1603005 00704020 00000005  
Feb 11 15:06:01 Q kernel:        c01359f2 c3fca320 c1437f68 c1437f68 c0136161 c3fca320 c1437f68 00000000  
Feb 11 15:06:01 Q kernel:        c1603000 00000000 c1437fa4 080b91c4 c1603000 080b91c4 c013581b 00000009  
Feb 11 15:06:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:06:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:07:01 Q kernel: c013d4a6 
Feb 11 15:07:01 Q kernel: Oops: 0000 
Feb 11 15:07:01 Q kernel: CPU:    0 
Feb 11 15:07:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:07:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:07:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:07:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c1437f04 
Feb 11 15:07:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:07:01 Q kernel: Process sh (pid: 13082, stackpage=c1437000) 
Feb 11 15:07:01 Q kernel: Stack: c1437f68 00000000 c3fca320 c1437fa4 c3fe8dc8 c35bb005 00704020 00000005  
Feb 11 15:07:01 Q kernel:        c01359f2 c3fca320 c1437f68 c1437f68 c0136161 c3fca320 c1437f68 00000000  
Feb 11 15:07:01 Q kernel:        c35bb000 00000000 c1437fa4 080b91c4 c35bb000 080b91c4 c013581b 00000009  
Feb 11 15:07:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:07:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:07:52 Q kernel: c013d4a6 
Feb 11 15:07:52 Q kernel: Oops: 0000 
Feb 11 15:07:52 Q kernel: CPU:    0 
Feb 11 15:07:52 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:07:52 Q kernel: EFLAGS: 00010213 
Feb 11 15:07:52 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:07:52 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c2b67f04 
Feb 11 15:07:52 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:07:52 Q kernel: Process ip-down (pid: 13089, stackpage=c2b67000) 
Feb 11 15:07:52 Q kernel: Stack: c2b67f68 00000000 c3fca320 c2b67fa4 c3fe8dc8 c1c51005 00704020 00000005  
Feb 11 15:07:52 Q kernel:        c01359f2 c3fca320 c2b67f68 c2b67f68 c0136161 c3fca320 c2b67f68 00000000  
Feb 11 15:07:52 Q kernel:        c1c51000 00000000 c2b67fa4 080b91c4 c1c51000 080b91c4 c013581b 00000009  
Feb 11 15:07:52 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:07:52 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:08:01 Q kernel: c013d4a6 
Feb 11 15:08:01 Q kernel: Oops: 0000 
Feb 11 15:08:01 Q kernel: CPU:    0 
Feb 11 15:08:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:08:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:08:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:08:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c2b67f04 
Feb 11 15:08:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:08:01 Q kernel: Process sh (pid: 13090, stackpage=c2b67000) 
Feb 11 15:08:01 Q kernel: Stack: c2b67f68 00000000 c3fca320 c2b67fa4 c3fe8dc8 c3bcd005 00704020 00000005  
Feb 11 15:08:01 Q kernel:        c01359f2 c3fca320 c2b67f68 c2b67f68 c0136161 c3fca320 c2b67f68 00000000  
Feb 11 15:08:01 Q kernel:        c3bcd000 00000000 c2b67fa4 080b91c4 c3bcd000 080b91c4 c013581b 00000009  
Feb 11 15:08:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:08:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Feb 11 15:09:01 Q kernel: c013d4a6 
Feb 11 15:09:01 Q kernel: Oops: 0000 
Feb 11 15:09:01 Q kernel: CPU:    0 
Feb 11 15:09:01 Q kernel: EIP:    0010:[d_lookup+98/252] 
Feb 11 15:09:01 Q kernel: EFLAGS: 00010213 
Feb 11 15:09:01 Q kernel: eax: c3fe8dc8   ebx: ffffffe8   ecx: 0000001a   edx: 00704020 
Feb 11 15:09:01 Q kernel: esi: 00000000   edi: c3fca320   ebp: 00000000   esp: c21f1f04 
Feb 11 15:09:01 Q kernel: ds: 0018   es: 0018   ss: 0018 
Feb 11 15:09:01 Q kernel: Process sh (pid: 13096, stackpage=c21f1000) 
Feb 11 15:09:01 Q kernel: Stack: c21f1f68 00000000 c3fca320 c21f1fa4 c3fe8dc8 c2d8f005 00704020 00000005  
Feb 11 15:09:01 Q kernel:        c01359f2 c3fca320 c21f1f68 c21f1f68 c0136161 c3fca320 c21f1f68 00000000  
Feb 11 15:09:01 Q kernel:        c2d8f000 00000000 c21f1fa4 080b91c4 c2d8f000 080b91c4 c013581b 00000009  
Feb 11 15:09:01 Q kernel: Call Trace: [cached_lookup+14/80] [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] [sys_newstat+21/108] [system_call+51/64]  
Feb 11 15:09:01 Q kernel: Code: 8b 6d 00 8b 54 24 18 39 53 48 75 76 8b 44 24 24 39 43 0c 75  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 48                  cmp    %edx,0x48(%ebx)
Code;  0000000a Before first symbol
   a:   75 76                     jne    82 <_EIP+0x82> 00000082 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


1 error issued.  Results may not be reliable.

--3V7upXqbjpZ4EhLz--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
