Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284817AbRLPVC0>; Sun, 16 Dec 2001 16:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284816AbRLPVCQ>; Sun, 16 Dec 2001 16:02:16 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:61194 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S284817AbRLPVCM>;
	Sun, 16 Dec 2001 16:02:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jan Tim Schueszler <Jan.Tim.Schueszler@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: {Kernel 2.4.17-pre8] Another kernel-oops
Date: Sun, 16 Dec 2001 22:01:23 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121622012300.04669@erde>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just discovered another kernel-oops with my 2.4.17-pre8-kernel. 
It occured during deleting a directory recursively.

Dec 16 21:53:49 erde kernel: invalid operand: 0000
Dec 16 21:53:49 erde kernel: CPU:    0
Dec 16 21:53:49 erde kernel: EIP:    0010:[prune_dcache+93/304]    
Not tainted
Dec 16 21:53:49 erde kernel: EFLAGS: 00010202
Dec 16 21:53:49 erde kernel: eax: 00000010   ebx: c77db1d8   ecx: 
c77db000   edx: c77db258
Dec 16 21:53:49 erde kernel: esi: c77db1c0   edi: 00000000   ebp: 
00000008   esp: c7b71f48
Dec 16 21:53:49 erde kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 21:53:49 erde kernel: Process rm (pid: 13831, 
stackpage=c7b71000)
Dec 16 21:53:49 erde kernel: Stack: c655b840 c6a46dfc c655b840 
c6a46d80 c013fd0d 00000074 c655b840 c01398e0
Dec 16 21:53:49 erde kernel:        c655b840 c655e33c c0139a21 
c655b840 c655b840 c655b840 cd8e2000 c7b71fa4 
Dec 16 21:53:49 erde kernel:        c0139b7f c6a46d80 c655b840 
c7b70000 bfffebf4 0804f0c0 bfffec9c c6c03140 
Dec 16 21:53:49 erde kernel: Call Trace: 
[shrink_dcache_parent+13/32] [d_unhash+32/80] [vfs_rmdir+273/432] 
[sys_rmdir+191/256] [system_call+51/56]
Dec 16 21:53:49 erde kernel: Code: 0f 0b 8d 46 10 8b 48 04 8b 53 f8 
89 4a 04 89 11 89 43 f8 89

Code;  d0d373f1 <END_OF_CODE+3c7bb0/????>
00000000 <_EIP>:
Code;  d0d373f1 <END_OF_CODE+3c7bb0/????>
   0:   0f 0b                     ud2a   
Code;  d0d373f3 <END_OF_CODE+3c7bb2/????>
   2:   8d 46 10                  lea    0x10(%esi),%eax
Code;  d0d373f6 <END_OF_CODE+3c7bb5/????>
   5:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  d0d373f9 <END_OF_CODE+3c7bb8/????>
   8:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  d0d373fc <END_OF_CODE+3c7bbb/????>
   b:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  d0d373ff <END_OF_CODE+3c7bbe/????>
   e:   89 11                     mov    %edx,(%ecx)
Code;  d0d37401 <END_OF_CODE+3c7bc0/????>
  10:   89 43 f8                  mov    %eax,0xfffffff8(%ebx)
Code;  d0d37404 <END_OF_CODE+3c7bc3/????>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.
