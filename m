Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285290AbRLSOJI>; Wed, 19 Dec 2001 09:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285291AbRLSOI6>; Wed, 19 Dec 2001 09:08:58 -0500
Received: from smtp01.fields.gol.com ([203.216.5.131]:7430 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S285290AbRLSOIp>; Wed, 19 Dec 2001 09:08:45 -0500
Date: Wed, 19 Dec 2001 23:08:12 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
        reiserfs-list <reiserfs-list@namesys.com>
Subject: reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-Id: <20011219230812.049c2c5c.masaruk@gol.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: "3UD?v?v'zSkYncgSd/w8_XIZeI<6UVWiR|O`MK|4r<R13hW),-w;.4EGFl]M=i9H/_&}\1 sKHvNj7@@1vM\{'-2s{Os@$kL9Tv_XHO2:2/DJSC5c\k:|=g{~sn(jc~EDth4,/}3.O0g8X/\5bhi2 ^{gjQFxH`RH{?z"Gqh5Kt^n%/v],ZNO"zO~Re
X-Operating-System: Kondara MNU/Linux 2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Dec 2001 18:26:03 -0200 (BRST)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> - Reiserfs fixes				(Oleg Drokin/Chris Mason)

There is still reiserfs remount problem with 2.4.17-rc2.

ksymoops 2.4.1 on i686 2.4.17-rc2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0010:[<c0159f54>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000003   ebx: 00000003   ecx: 00000000   edx: 00000000
esi: df81b048   edi: df81b000   ebp: 00001000   esp: df829b08
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 119, stackpage=df829000)
Stack: 00000006 df6468c0 df829d3c 00000000 c17e2b80 c0122223 08056c54 dfb80440 
       00000001 df97bf20 c01222d9 dfb80440 dfef8c00 dfef8c00 00000003 00000000 
       00000000 c17e0680 00000001 00000000 00000002 00000000 00000000 df829bb4 
Call Trace: [<c0122223>] [<c01222d9>] [<c015a2dd>] [<c015a0ba>] [<c0132b15>] 
   [<c0124566>] [<c0133206>] [<c015a0a4>] [<c015c2db>] [<c015a0a4>] [<c015c3c8>] 
   [<c0163b2e>] [<c016191b>] [<c01621b5>] [<c0135372>] [<c01440d5>] [<c0144365>] 
   [<c0144224>] [<c0144444>] [<c0106d73>] 
Code: 0f 0b 83 7c 24 58 00 75 13 8b 46 08 89 44 24 48 c7 44 24 4c 

>>EIP; c0159f54 <_get_block_create_0+748/85c>   <=====
Trace; c0122223 <do_no_page+137/190>
Trace; c01222d9 <handle_mm_fault+5d/c0>
Trace; c015a2dd <reiserfs_get_block+10d/eac>
Trace; c015a0ba <reiserfs_get_block_create_0+16/1c>
Trace; c0132b15 <__block_prepare_write+f5/23c>
Trace; c0124566 <find_or_create_page+c6/dc>
Trace; c0133206 <block_prepare_write+22/5c>
Trace; c015a0a4 <reiserfs_get_block_create_0+0/1c>
Trace; c015c2db <grab_tail_page+8b/128>
Trace; c015a0a4 <reiserfs_get_block_create_0+0/1c>
Trace; c015c3c8 <reiserfs_truncate_file+50/1b0>
Trace; c0163b2e <reiserfs_warning+1e/24>
Trace; c016191b <finish_unfinished+25b/2e4>
Trace; c01621b5 <reiserfs_remount+141/150>
Trace; c0135372 <do_remount_sb+a6/d4>
Trace; c01440d5 <do_remount+75/a0>
Trace; c0144365 <do_mount+f1/14c>
Trace; c0144224 <copy_mount_options+50/a0>
Trace; c0144444 <sys_mount+84/c4>
Trace; c0106d73 <system_call+33/38>
Code;  c0159f54 <_get_block_create_0+748/85c>
00000000 <_EIP>:
Code;  c0159f54 <_get_block_create_0+748/85c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0159f56 <_get_block_create_0+74a/85c>
   2:   83 7c 24 58 00            cmpl   $0x0,0x58(%esp,1)
Code;  c0159f5b <_get_block_create_0+74f/85c>
   7:   75 13                     jne    1c <_EIP+0x1c> c0159f70 <_get_block_create_0+764/85c>
Code;  c0159f5d <_get_block_create_0+751/85c>
   9:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c0159f60 <_get_block_create_0+754/85c>
   c:   89 44 24 48               mov    %eax,0x48(%esp,1)
Code;  c0159f64 <_get_block_create_0+758/85c>
  10:   c7 44 24 4c 00 00 00      movl   $0x0,0x4c(%esp,1)
Code;  c0159f6b <_get_block_create_0+75f/85c>
  17:   00 

Thanks.
-- 
Masaru Kawashima <masaruk@gol.com>
