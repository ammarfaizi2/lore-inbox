Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316654AbSFKCQ4>; Mon, 10 Jun 2002 22:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSFKCQz>; Mon, 10 Jun 2002 22:16:55 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:11712 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316654AbSFKCQz>; Mon, 10 Jun 2002 22:16:55 -0400
Message-ID: <3D055C28.7030801@linuxhq.com>
Date: Mon, 10 Jun 2002 22:10:48 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Kernel 2.5.21 - IDE 86
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


flushing ide devices: hda <1> Unable to handle kernel NULL pointer at 
address 00000004
*pde = 000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01a692c>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c03077d0 ebx: c03077b8 ecx: 00000000 edx: 00000000
esi: c258e000 edi: c029ef40 ebp: c030766c esp: c258fe40
ds: 0018 es: 0018 ss: 0018
Stack: c030766c c03077b8 c0307540 00000001 c01a6d24 c03077b8 c0295788 
c030766c
        c01eaf9e c03077b8 c0307540 c0307540 c01e271f c030766c c0307670 
c029e9cc
        00000000 00000003 bffffcd8 c0122fdd c029e9cc 00000003 00000000 
4321fedc
Call Trace: [<c01a6d24>] [<c01eaf9d>] [<c01e271f>] [<c0122fdd>] [<c0123576>]
             [<c011331e>] [<c0121413>] [<c01217fe>] [<c0122438>] 
[<c01512e0>] [<c013e01a>]
             [<c013c373>] [<c013c422>] [<c010740f>]
Code: 89 4a 04 89 11 89 40 04 89 43 18 ff 4e 10 8b 46 08 83 e0 08

 >>EIP; c01a692c <device_detach+4c/b0>   <=====
Trace; c01a6d24 <put_device+74/c0>
Trace; c01eaf9d <idedisk_cleanup+1d/80>
Trace; c01e271f <ata_sys_notify+bf/e0>
Trace; c0122fdd <notifier_call_chain+2d/50>
Trace; c0123576 <sys_reboot+2a6/2e0>
Trace; c011331e <wake_up_process+e/20>
Trace; c0121413 <deliver_signal+73/80>
Trace; c01217fe <kill_proc_info+ae/d0>
Trace; c0122438 <sys_kill+58/60>
Trace; c01512e0 <dput+30/150>
Trace; c013e01a <fput+ea/140>
Trace; c013c373 <filp_close+83/d0>
Trace; c013c422 <sys_close+62/a0>
Trace; c010740f <syscall_call+7/b>
Code;  c01a692c <device_detach+4c/b0>
00000000 <_EIP>:
Code;  c01a692c <device_detach+4c/b0>   <=====
    0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c01a692f <device_detach+4f/b0>
    3:   89 11                     mov    %edx,(%ecx)
Code;  c01a6931 <device_detach+51/b0>
    5:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c01a6934 <device_detach+54/b0>
    8:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c01a6937 <device_detach+57/b0>
    b:   ff 4e 10                  decl   0x10(%esi)
Code;  c01a693a <device_detach+5a/b0>
    e:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c01a693d <device_detach+5d/b0>
   11:   83 e0 08                  and    $0x8,%eax

