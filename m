Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVCYEOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVCYEOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCYEOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:14:11 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:57011 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261210AbVCYEMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:12:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BX0xZdyDxzwdbt/Uy0d4OAzOthSy4caGY8kVdjcjyrMLm+lgIMrHN6p17+gMDaHarIdP3vWhC7Agt8Vku7bp85/RYAM+XjAoaircRk13vUJ2aDztAOnFlXXWZviN/+Z4qRLhrYsmFDbVthTuWLWDY3O605khJDn8jlLn0u3GGN8=
Message-ID: <a44ae5cd05032420122cd610bd@mail.gmail.com>
Date: Thu, 24 Mar 2005 23:12:50 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050324044114.5aa5b166.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050324044114.5aa5b166.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@Monkey100:/sys/class/i2c-adapter# ls * -l
root@Monkey100:/sys# cat */*/*/*

ksymoops 2.4.9 on i686 2.6.12-rc1-mm2.  Options used
     -o /lib/modules/2.6.12-rc1-mm2 (specified)
     -m /boot/System.map-2.6.12-rc1-mm2 (specified)

Unable to handle kernel paging request at virtual address 24fc1024
c0198448
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0198448>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210206   (2.6.12-rc1-mm2)
eax: 00000001   ebx: c039f820   ecx: 00000001   edx: 24fc1000
esi: e75b6cc4   edi: f7c015e4   ebp: e7b93e94   esp: e7b93e94
ds: 007b   es: 007b   ss: 0068
Stack: e7b93eb8 c0198644 f7c01694 00000000 f7c015e4 e7b93eb8 c039f820 e75b6cc4
       f7c015e4 e7b93edc c0198790 f7c01694 f7c015e4 e712a000 f7c01694 e712a000
       fffffff4 e7b93f10 e7b93ef8 c019884f e75b6cc4 e712a000 ffffffea e75b6cc4
Call Trace:
 [<c010410f>] show_stack+0x7f/0xa0
 [<c01042aa>] show_registers+0x15a/0x1c0
 [<c01044ac>] die+0xfc/0x190
 [<c011450b>] do_page_fault+0x31b/0x670
 [<c0103cf3>] error_code+0x4f/0x54
 [<c0198644>] sysfs_get_target_path+0x14/0x80
 [<c0198790>] sysfs_getlink+0xe0/0x150
 [<c019884f>] sysfs_follow_link+0x4f/0x60
 [<c016b46f>] generic_readlink+0x2f/0x90
 [<c01635b6>] sys_readlink+0x86/0x90
 [<c0103249>] syscall_call+0x7/0xb
Code: 42 70 e8 a4 fc 19 00 e9 f3 fe ff ff 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 31 c0 89 e5 8b 55 08<8b>
52 24 40 85 d2 75 f8 c9 c3 8d b4 26 00 00 00 00 8d bc 27 00


>>EIP; c0198448 <object_depth+8/20>   <=====

>>ebx; c039f820 <sysfs_rename_sem+0/c>
>>edx; 24fc1000 <phys_startup_32+24ec1000/c0000000>
>>esi; e75b6cc4 <pg0+270ebcc4/3fb33400>
>>edi; f7c015e4 <pg0+377365e4/3fb33400>
>>ebp; e7b93e94 <pg0+276c8e94/3fb33400>
>>esp; e7b93e94 <pg0+276c8e94/3fb33400>

Trace; c010410f <show_stack+7f/a0>
Trace; c01042aa <show_registers+15a/1c0>
Trace; c01044ac <die+fc/190>
Trace; c011450b <do_page_fault+31b/670>
Trace; c0103cf3 <error_code+4f/54>
Trace; c0198644 <sysfs_get_target_path+14/80>
Trace; c0198790 <sysfs_getlink+e0/150>
Trace; c019884f <sysfs_follow_link+4f/60>
Trace; c016b46f <generic_readlink+2f/90>
Trace; c01635b6 <sys_readlink+86/90>
Trace; c0103249 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019841d <.text.lock.dir+d7/fa>
00000000 <_EIP>:
Code;  c019841d <.text.lock.dir+d7/fa>
   0:   42                        inc    %edx
Code;  c019841e <.text.lock.dir+d8/fa>
   1:   70 e8                     jo     ffffffeb <_EIP+0xffffffeb>
Code;  c0198420 <.text.lock.dir+da/fa>
   3:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c0198421 <.text.lock.dir+db/fa>
   4:   fc                        cld
Code;  c0198422 <.text.lock.dir+dc/fa>
   5:   19 00                     sbb    %eax,(%eax)
Code;  c0198424 <.text.lock.dir+de/fa>
   7:   e9 f3 fe ff ff            jmp    fffffeff <_EIP+0xfffffeff>
Code;  c0198429 <.text.lock.dir+e3/fa>
   c:   90                        nop
Code;  c019842a <.text.lock.dir+e4/fa>
   d:   90                        nop
Code;  c019842b <.text.lock.dir+e5/fa>
   e:   90                        nop
Code;  c019842c <.text.lock.dir+e6/fa>
   f:   90                        nop
Code;  c019842d <.text.lock.dir+e7/fa>
  10:   90                        nop
Code;  c019842e <.text.lock.dir+e8/fa>
  11:   90                        nop
Code;  c019842f <.text.lock.dir+e9/fa>
  12:   90                        nop
Code;  c0198430 <.text.lock.dir+ea/fa>
  13:   90                        nop
Code;  c0198431 <.text.lock.dir+eb/fa>
  14:   90                        nop
Code;  c0198432 <.text.lock.dir+ec/fa>
  15:   90                        nop
Code;  c0198433 <.text.lock.dir+ed/fa>
  16:   90                        nop
Code;  c0198434 <.text.lock.dir+ee/fa>
  17:   90                        nop
Code;  c0198435 <.text.lock.dir+ef/fa>
  18:   90                        nop
Code;  c0198436 <.text.lock.dir+f0/fa>
  19:   90                        nop
Code;  c0198437 <.text.lock.dir+f1/fa>
  1a:   90                        nop
Code;  c0198438 <.text.lock.dir+f2/fa>
  1b:   90                        nop
Code;  c0198439 <.text.lock.dir+f3/fa>
  1c:   90                        nop
Code;  c019843a <.text.lock.dir+f4/fa>
  1d:   90                        nop
Code;  c019843b <.text.lock.dir+f5/fa>
  1e:   90                        nop
Code;  c019843c <.text.lock.dir+f6/fa>
  1f:   90                        nop
Code;  c019843d <.text.lock.dir+f7/fa>
  20:   90                        nop
Code;  c019843e <.text.lock.dir+f/60>
Trace; c01681de <__link_path_walk+8ce/ec0>
Trace; c016885f <link_path_walk+8f/190>
Trace; c0168c45 <path_lookup+95/170>
Trace; c01693ef <open_namei+7f/650>
Trace; c015823c <filp_open+3c/60>
Trace; c01586e8 <sys_open+48/d0>
Trace; c0103249 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019841d <.text.lock.dir+d7/fa>
00000000 <_EIP>:
Code;  c019841d <.text.lock.dir+d7/fa>
   0:   42                        inc    %edx
Code;  c019841e <.text.lock.dir+d8/fa>
   1:   70 e8                     jo     ffffffeb <_EIP+0xffffffeb>
Code;  c0198420 <.text.lock.dir+da/fa>
   3:   a4                        movsb  %ds:(%esi),%es:(%

----------------------------------------------

 <1>Unable to handle kernel paging request at virtual address 36bc3024
c0198448
*pde = 00000000
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c0198448>]    Not tainted VLI
EFLAGS: 00210206   (2.6.12-rc1-mm2)
eax: 00000001   ebx: c039f820   ecx: 00000001   edx: 36bc3000
esi: e75b6cc4   edi: f7c015e4   ebp: e3423dc4   esp: e3423dc4
ds: 007b   es: 007b   ss: 0068
Stack: e3423de8 c0198644 f7c01694 00000000 f7c015e4 e3423de8 c039f820 e75b6cc4
       f7c015e4 e3423e0c c0198790 f7c01694 f7c015e4 e02fe000 f7c01694 e02fe000
       fffffff4 e3423f50 e3423e28 c019884f e75b6cc4 e02fe000 e3423e64 e3422000
Call Trace:
 [<c010410f>] show_stack+0x7f/0xa0
 [<c01042aa>] show_registers+0x15a/0x1c0
 [<c01044ac>] die+0xfc/0x190
 [<c011450b>] do_page_fault+0x31b/0x670
 [<c0103cf3>] error_code+0x4f/0x54
 [<c0198644>] sysfs_get_target_path+0x14/0x80
 [<c0198790>] sysfs_getlink+0xe0/0x150
 [<c019884f>] sysfs_follow_link+0x4f/0x60
 [<c01681de>] __link_path_walk+0x8ce/0xec0
 [<c016885f>] link_path_walk+0x8f/0x190
 [<c0168c45>] path_lookup+0x95/0x170
 [<c01693ef>] open_namei+0x7f/0x650
 [<c015823c>] filp_open+0x3c/0x60
 [<c01586e8>] sys_open+0x48/0xd0
 [<c0103249>] syscall_call+0x7/0xb
Code: 42 70 e8 a4 fc 19 00 e9 f3 fe ff ff 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 31 c0 89 e5 8b 55 08<8b>
52 24 40 85 d2 75 f8 c9 c3 8d b4 26 00 00 00 00 8d bc 27 00

>>EIP; c0198448 <object_depth+8/20>   <=====

>>ebx; c039f820 <sysfs_rename_sem+0/c>
>>edx; 36bc3000 <phys_startup_32+36ac3000/c0000000>
>>esi; e75b6cc4 <pg0+270ebcc4/3fb33400>
>>edi; f7c015e4 <pg0+377365e4/3fb33400>
>>ebp; e3423dc4 <pg0+22f58dc4/3fb33400>
>>esp; e3423dc4 <pg0+22f58dc4/3fb33400>

Trace; c010410f <show_stack+7f/a0>
Trace; c01042aa <show_registers+15a/1c0>
Trace; c01044ac <die+fc/190>
Trace; c011450b <do_page_fault+31b/670>
Trace; c0103cf3 <error_code+4f/54>
Trace; c0198644 <sysfs_get_target_path+14/80>
Trace; c0198790 <sysfs_getlink+e0/150>
Trace; c019884f <sysfs_follow_link+4f/60>
Trace; c01681de <__link_path_walk+8ce/ec0>
Trace; c016885f <link_path_walk+8f/190>
Trace; c0168c45 <path_lookup+95/170>
Trace; c01693ef <open_namei+7f/650>
Trace; c015823c <filp_open+3c/60>
Trace; c01586e8 <sys_open+48/d0>
Trace; c0103249 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019841d <.text.lock.dir+d7/fa>
00000000 <_EIP>:
Code;  c019841d <.text.lock.dir+d7/fa>
   0:   42                        inc    %edx
Code;  c019841e <.text.lock.dir+d8/fa>
   1:   70 e8                     jo     ffffffeb <_EIP+0xffffffeb>
Code;  c0198420 <.text.lock.dir+da/fa>
   3:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c0198421 <.text.lock.dir+db/fa>
   4:   fc                        cld
Code;  c0198422 <.text.lock.dir+dc/fa>
   5:   19 00                     sbb    %eax,(%eax)
Code;  c0198424 <.text.lock.dir+de/fa>
   7:   e9 f3 fe ff ff            jmp    fffffeff
<_EIP+0xfffftext.lock.dir+f1/fa>
  1a:   90                        nop
Code;  c0198438 <.text.lock.dir+f2/fa>
  1b:   90                        nop
Code;  c0198439 <.text.lock.dir+f3/fa>
  1c:   90                        nop
Code;  c019843a <.text.lock.dir+f4/fa>
  1d:   90                        nop
Code;  c019843b <.text.lock.dir+f5/fa>
  1e:   90                        nop
Code;  c019843c <.text.lock.dir+f6/fa>
  1f:   90                        nop
Code;  c019843d <.text.lock.dir+f7/fa>
  20:   90                        nop
Code;  c019843e <.text.lock.dir+f8/fa>
  21:   90                        nop
Code;  c019843f <.text.lock.dir+f9/fa>
  22:   90                        nop
Code;  c0198440 <object_depth+0/20>
  23:   55                        push   %ebp
Code;  c0198441 <object_depth+1/20>
  24:   31 c0                     xor    %eax,%eax
Code;  c0198443 <object_depth+3/20>
  26:   89 e5                     mov    %esp,%ebp
Code;  c0198445 <object_depth+5/20>
  28:   8b 55 08                  mov    0x8(%ebp),%edx

This decode from eip onwards should be reliable

Code;  c0198448 <object_depth+8/20>
00000000 <_EIP>:
Code;  c0198448 <object_depth+8/20>   <=====
   0:   8b 52 24                  mov    0x24(%edx),%edx   <=====
Code;  c019844b <object_depth+b/20>
   3:   40                        inc    %eax
Code;  c019844c <object_depth+c/20>
   4:   85 d2                     test   %edx,%edx
Code;  c019844e <object_depth+e/20>
   6:   75 f8                     jne    0 <_EIP>
Code;  c0198450 <object_depth+10/20>
   8:   c9                        leave
Code;  c0198451 <object_depth+11/20>
   9:   c3                        ret
Code;  c0198452 <object_depth+12/20>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c0198459 <object_depth+19/20>
  11:   8d                        .byte 0x8d
Code;  c019845a <object_depth+1a/20>
  12:   bc                        .byte 0xbc
Code;  c019845b <object_depth+1b/20>
  13:   27                        daa
