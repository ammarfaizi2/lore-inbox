Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRAWQY3>; Tue, 23 Jan 2001 11:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRAWQYJ>; Tue, 23 Jan 2001 11:24:09 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:7684 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S129969AbRAWQYH> convert rfc822-to-8bit;
	Tue, 23 Jan 2001 11:24:07 -0500
Date: Tue, 23 Jan 2001 18:24:01 +0200 (EET)
From: Pasi Kärkkäinen <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS with 2.2.18
Message-ID: <Pine.LNX.4.31.0101231819200.23324-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unable to handle kernel paging request at virtual address f6cefb13
current->tss.cr3 = 0bdd0000, %cr3 = 0bdd0000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01270fa>]
EFLAGS: 00010282
eax: f6cefb13   ebx: 1643ad00   ecx: 0005c864   edx: f6cefb13
esi: c4b40341   edi: 002c875a   ebp: 00001000   esp: d41b1e60
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 10536, process nr: 103, stackpage=d41b1000)
Stack: 002c875a 0000005a 00000000 c4b4732c c012763a 00652400 c4b47300
c0143a0b
       00000341 002c875a 00001000 00000008 00000400 cbc6f2a0 00000000
00000246
       c0201c00 d41b0000 00000246 002c642d 00000341 d6479168 00000008
00000400
Call Trace: [<c012763a>] [<c0143a0b>] [<c0143ca4>] [<c0143e97>]
[<c013f3f8>] [<c013f40e>] [<c0132aaf>]
       [<c0131af2>] [<c01419cc>] [<c012d61d>] [<c012d693>] [<c010a0f0>]
Code: 8b 12 39 78 04 75 f3 39 68 08 75 ee 66 39 70 0c 75 e8 89 c2


ksymoops:


ksymoops 2.3.4 on i686 2.2.18.  Options used
     -v /usr/src/linux-2.2.18/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-2.2.18 (specified)

Unable to handle kernel paging request at virtual address f6cefb13
current->tss.cr3 = 0bdd0000, %cr3 = 0bdd0000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01270fa>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: f6cefb13   ebx: 1643ad00   ecx: 0005c864   edx: f6cefb13
esi: c4b40341   edi: 002c875a   ebp: 00001000   esp: d41b1e60
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 10536, process nr: 103, stackpage=d41b1000)
Stack: 002c875a 0000005a 00000000 c4b4732c c012763a 00652400 c4b47300
c0143a0b
       00000341 002c875a 00001000 00000008 00000400 cbc6f2a0 00000000
00000246
       c0201c00 d41b0000 00000246 002c642d 00000341 d6479168 00000008
00000400
Call Trace: [<c012763a>] [<c0143a0b>] [<c0143ca4>] [<c0143e97>]
[<c013f3f8>]
[<c013f40e>] [<c0132aaf>]
       [<c0131af2>] [<c01419cc>] [<c012d61d>] [<c012d693>] [<c010a0f0>]
Code: 8b 12 39 78 04 75 f3 39 68 08 75 ee 66 39 70 0c 75 e8 89 c2

>>EIP; c01270fa <find_buffer+72/90>   <=====
Trace; c012763a <refile_buffer+4e/a4>
Trace; c0143a0b <trunc_indirect+1c7/2e0>
Trace; c0143ca4 <trunc_dindirect+180/1b4>
Trace; c0143e97 <ext2_truncate+87/1d0>
Trace; c013f3f8 <ext2_delete_inode+64/88>
Trace; c013f40e <ext2_delete_inode+7a/88>
Trace; c0132aaf <iput+83/1f0>
Trace; c0131af2 <d_delete+4e/6c>
Trace; c01419cc <ext2_unlink+170/190>
Trace; c012d61d <vfs_unlink+e5/f0>
Trace; c012d693 <sys_unlink+6b/a0>
Trace; c010a0f0 <system_call+34/38>
Code;  c01270fa <find_buffer+72/90>
00000000 <_EIP>:
Code;  c01270fa <find_buffer+72/90>   <=====
   0:   8b 12                     mov    (%edx),%edx   <=====
Code;  c01270fc <find_buffer+74/90>
   2:   39 78 04                  cmp    %edi,0x4(%eax)
Code;  c01270ff <find_buffer+77/90>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa>
c01270f4 <f
Code;  c0127101 <find_buffer+79/90>
   7:   39 68 08                  cmp    %ebp,0x8(%eax)
Code;  c0127104 <find_buffer+7c/90>
   a:   75 ee                     jne    fffffffa <_EIP+0xfffffffa>
c01270f4 <f
Code;  c0127106 <find_buffer+7e/90>
   c:   66 39 70 0c               cmp    %si,0xc(%eax)
Code;  c012710a <find_buffer+82/90>
  10:   75 e8                     jne    fffffffa <_EIP+0xfffffffa>
c01270f4 <f
Code;  c012710c <find_buffer+84/90>
  12:   89 c2                     mov    %eax,%edx



This is on a PII 333MHz and 384MB of RAM. Both IDE and SCSI in use.
Additional information available on request..


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
