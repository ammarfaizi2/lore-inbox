Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHaBgc>; Fri, 30 Aug 2002 21:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSHaBgc>; Fri, 30 Aug 2002 21:36:32 -0400
Received: from [210.78.155.203] ([210.78.155.203]:260 "EHLO discovery")
	by vger.kernel.org with ESMTP id <S315690AbSHaBgb>;
	Fri, 30 Aug 2002 21:36:31 -0400
Date: Sat, 31 Aug 2002 03:07:48 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: software suspend in 2.5.32 test reporter.
Message-Id: <20020831030748.43ab8094.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.7.8claws9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pavel Machek:

2.5.32 without CONFIG_PM , it work fine in my machine.
2.5.32 with CONFIG_PM, Oops in add_timer.
       
Here is Oops , it is hardcopy from CRT.
c0119cd5
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0119cd5>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: cf902ec4 ebx: cf902ec4 ecx: 00000012 edx: 00000000
esi: cf902ec4 edi: cf902d60 ebp: 00003000 esp: cd647e64
Stack: 0000300c d1864121 cf902ec4 cff79c00
Call Trace: [<d1864121>] [<d18630c0>] [<c016eda3>] [<c106ee69>] [<c016ee86>]
Code: 89 5a 04 89 13 89 43 04 89 18 51 9d eb 14 51 9d 8b 44 24 04


>>EIP; c0119cd5 <add_timer+a5/cc>   <=====

>>eax; cf902ec4 <_end+f66ca38/11574bd4>
>>ebx; cf902ec4 <_end+f66ca38/11574bd4>
>>esi; cf902ec4 <_end+f66ca38/11574bd4>
>>edi; cf902d60 <_end+f66c8d4/11574bd4>
>>esp; cd647e64 <_end+d3b19d8/11574bd4>

Trace; d1864121 <END_OF_CODE+213de/????>
Trace; d18630c0 <END_OF_CODE+2037d/????>
Trace; c016eda3 <pci_pm_resume_device+1b/20>
Trace; c106ee69 <_end+dd89dd/11574bd4>
Trace; c016ee86 <pci_pm_resume_bus+3a/4c>

Code;  c0119cd5 <add_timer+a5/cc>
00000000 <_EIP>:
Code;  c0119cd5 <add_timer+a5/cc>   <=====
   0:   89 5a 04                  mov    %ebx,0x4(%edx)   <=====
Code;  c0119cd8 <add_timer+a8/cc>
   3:   89 13                     mov    %edx,(%ebx)
Code;  c0119cda <add_timer+aa/cc>
   5:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c0119cdd <add_timer+ad/cc>
   8:   89 18                     mov    %ebx,(%eax)
Code;  c0119cdf <add_timer+af/cc>
   a:   51                        push   %ecx
Code;  c0119ce0 <add_timer+b0/cc>
   b:   9d                        popf   
Code;  c0119ce1 <add_timer+b1/cc>
   c:   eb 14                     jmp    22 <_EIP+0x22> c0119cf7 <add_timer+c7/cc>
Code;  c0119ce3 <add_timer+b3/cc>
   e:   51                        push   %ecx
Code;  c0119ce4 <add_timer+b4/cc>
   f:   9d                        popf   
Code;  c0119ce5 <add_timer+b5/cc>
  10:   8b 44 24 04               mov    0x4(%esp,1),%eax



-- 
		--- Hu Gang
