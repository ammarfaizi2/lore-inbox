Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSJ3Ikb>; Wed, 30 Oct 2002 03:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSJ3Ikb>; Wed, 30 Oct 2002 03:40:31 -0500
Received: from fe-mail.whowhere.com ([209.202.220.140]:51704 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S264624AbSJ3IkV>;
	Wed, 30 Oct 2002 03:40:21 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2002 09:46:28 +0100
From: "svetljo" <svetljo@lycos.com>
Message-ID: <MGIGJDKMHJEGAAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: svetljo@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: OOPSES:2.5.45ac5 -smbfs, cifs,ntfs
X-Sender-Ip: 217.237.159.6
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: multipart/mixed; boundary="=_-=_-NMOBGDKMHJEGAAAA"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
You need a MIME compliant mail reader to completely decode it.

--=_-=_-NMOBGDKMHJEGAAAA
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Length: 1557
Content-Transfer-Encoding: 7bit

Hi i just tryed out linux-2.5.44ac5,
but i got too many oopses in smbfs, cifs, ntfs

ver_linux:

Linux tux.mdk-local 2.4.19-pre10-jam3 #5 Fri Oct 11 01:22:06 CEST 2002 i686 unknown unknown GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11w
mount                  2.11w
modutils               2.4.19
e2fsprogs              1.27ea
jfsutils               1.0.21
reiserfsprogs          3.6.3
xfsprogs               2.0.6
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.10
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         smbfs sd_mod floppy binfmt_misc r128 agpgart snd-seq-midi snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore af_packet 8139too mii usb-storage scsi_mod via686a lm80 eeprom i2c-proc i2c-isa i2c-viapro i2c-core usb-uhci usbcore rtc
------------------------------------------------------------





---
Svetoslav Dimitrov Slavtschev

svetljo@lycos.com
svetoslav@web.de



__________________________________________________________
Outgrown your current e-mail service? Get 25MB Storage, POP3 Access,
Advanced Spam protection with LYCOS MAIL PLUS.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
--=_-=_-NMOBGDKMHJEGAAAA
Content-Type: text/plain; charset=us-ascii; name="2.5.44ac5cifsOopses.txt"
Content-Language: en
Content-Length: 11799
Content-Transfer-Encoding: 7bit

[root@tux 2.5.44-ac5]# dmesg | ksymoops
ksymoops 2.4.5 on i686 2.5.44-ac5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44-ac5/ (default)
     -m /boot/System.map-2.5.44-ac5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CIFS: Unrecognized mount option debug = 4cifs_mount failed w/return code = -5
 Guest loginUID = 0 CIFS Session Established successfully <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c018eddd
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018eddd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 00000000   ebx: 00000000   ecx: 0000001f   edx: ecbe9740
esi: 00000000   edi: ecbe9740   ebp: 00000014   esp: ca7fbda0
ds: 0068   es: 0068   ss: 0068
Stack: c0367aa0 ecbe96c0 00000000 00000000 ca7fbe38 ca7fbe18 f0a18b00 00000054
       00000000 ecbe96c0 d937dbf4 c01300bc d937dbf8 00000040 00000054 c13c3f48
       00000000 00000000 b9424879 4cbd714f de9f1080 ecbe9480 c0354e60 2000db88
Call Trace: [<f0a18b00>]  [<c01300bc>]  [<f0a18b00>]  [<c018800f>]  [<c018804b>]  [<c0188206>]  [<c01885a1>]  [<c014db7f>]  [<c01628d0>]  [<c0162c21>]  [<c0163008>]  [<c01093fb>]
Code: ac aa 84 c0 75 f7 f3 aa 8b 44 24 54 ff 40 68 e9 73 fb ff ff


>>EIP; c018eddd <cifs_mount+5ed/9b0>   <=====

>>edx; ecbe9740 <_end+2c76ad4c/3049766c>
>>edi; ecbe9740 <_end+2c76ad4c/3049766c>
>>esp; ca7fbda0 <_end+a37d3ac/3049766c>

Trace; f0a18b00 <[nls_iso8859-1]table+0/1b>
Trace; c01300bc <find_get_page+2c/60>
Trace; f0a18b00 <[nls_iso8859-1]table+0/1b>
Trace; c018800f <find_nls+5f/80>
Trace; c018804b <load_nls+1b/a0>
Trace; c0188206 <cifs_read_super+76/160>
Trace; c01885a1 <cifs_get_sb+81/d0>
Trace; c014db7f <do_kern_mount+5f/e0>
Trace; c01628d0 <do_add_mount+90/190>
Trace; c0162c21 <do_mount+181/1d0>
Trace; c0163008 <sys_mount+c8/100>
Trace; c01093fb <syscall_call+7/b>

Code;  c018eddd <cifs_mount+5ed/9b0>
00000000 <_EIP>:
Code;  c018eddd <cifs_mount+5ed/9b0>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c018edde <cifs_mount+5ee/9b0>
   1:   aa                        stos   %al,%es:(%edi)
Code;  c018eddf <cifs_mount+5ef/9b0>
   2:   84 c0                     test   %al,%al
Code;  c018ede1 <cifs_mount+5f1/9b0>
   4:   75 f7                     jne    fffffffd <_EIP+0xfffffffd> c018edda <cifs_mount+5ea/9b0>
Code;  c018ede3 <cifs_mount+5f3/9b0>
   6:   f3 aa                     repz stos %al,%es:(%edi)
Code;  c018ede5 <cifs_mount+5f5/9b0>
   8:   8b 44 24 54               mov    0x54(%esp,1),%eax
Code;  c018ede9 <cifs_mount+5f9/9b0>
   c:   ff 40 68                  incl   0x68(%eax)
Code;  c018edec <cifs_mount+5fc/9b0>
   f:   e9 73 fb ff ff            jmp    fffffb87 <_EIP+0xfffffb87> c018e964 <cifs_mount+174/9b0>

UNC: \\192.168.0.103\books  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c018e2a6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018e2a6>]    Not tainted
EFLAGS: 00010212
eax: d6569d00   ebx: ecbe96c0   ecx: 0000001f   edx: ecbe9480
esi: ecbe9741   edi: 00000000   ebp: 00000020   esp: d6569d84
ds: 0068   es: 0068   ss: 0068
Stack: c035646f 0000002b 00000000 d8e7de00 da107000 00000015 c018e925 6700a8c0
       00000000 d6569df4 00000000 c1794acc 00000001 00000000 00000054 00000000
       00000000 d937dbf4 c01300bc d937dbf8 00000040 00000054 c13c3f48 c01311a3
Call Trace: [<c018e925>]  [<c01300bc>]  [<c01311a3>]  [<c013aef2>]  [<c02956e9>]  [<c0118dac>]  [<f0a18b00>]  [<c018800f>]  [<c018804b>]  [<c0188206>]  [<c01885a1>]  [<c014db7f>]  [<c01628d0>]  [<c0162c21>]  [<c03452be>]  [<c0163008>]  [<c01093fb>]
Code: ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 04 8b


>>EIP; c018e2a6 <find_tcp_session+a6/e0>   <=====

>>eax; d6569d00 <_end+160eb30c/3049766c>
>>ebx; ecbe96c0 <_end+2c76accc/3049766c>
>>edx; ecbe9480 <_end+2c76aa8c/3049766c>
>>esi; ecbe9741 <_end+2c76ad4d/3049766c>
>>esp; d6569d84 <_end+160eb390/3049766c>

Trace; c018e925 <cifs_mount+135/9b0>
Trace; c01300bc <find_get_page+2c/60>
Trace; c01311a3 <filemap_nopage+1e3/2d0>
Trace; c013aef2 <do_no_page+122/2d0>
Trace; c02956e9 <vt_console_print+59/310>
Trace; c0118dac <try_to_wake_up+ec/100>
Trace; f0a18b00 <[nls_iso8859-1]table+0/1b>
Trace; c018800f <find_nls+5f/80>
Trace; c018804b <load_nls+1b/a0>
Trace; c0188206 <cifs_read_super+76/160>
Trace; c01885a1 <cifs_get_sb+81/d0>
Trace; c014db7f <do_kern_mount+5f/e0>
Trace; c01628d0 <do_add_mount+90/190>
Trace; c0162c21 <do_mount+181/1d0>
Trace; c03452be <__generic_copy_from_user+3e/70>
Trace; c0163008 <sys_mount+c8/100>
Trace; c01093fb <syscall_call+7/b>

Code;  c018e2a6 <find_tcp_session+a6/e0>
00000000 <_EIP>:
Code;  c018e2a6 <find_tcp_session+a6/e0>   <=====
   0:   ae                        scas   %es:(%edi),%al   <=====
Code;  c018e2a7 <find_tcp_session+a7/e0>
   1:   75 08                     jne    b <_EIP+0xb> c018e2b1 <find_tcp_session+b1/e0>
Code;  c018e2a9 <find_tcp_session+a9/e0>
   3:   84 c0                     test   %al,%al
Code;  c018e2ab <find_tcp_session+ab/e0>
   5:   75 f5                     jne    fffffffc <_EIP+0xfffffffc> c018e2a2 <find_tcp_session+a2/e0>
Code;  c018e2ad <find_tcp_session+ad/e0>
   7:   31 c0                     xor    %eax,%eax
Code;  c018e2af <find_tcp_session+af/e0>
   9:   eb 04                     jmp    f <_EIP+0xf> c018e2b5 <find_tcp_session+b5/e0>
Code;  c018e2b1 <find_tcp_session+b1/e0>
   b:   19 c0                     sbb    %eax,%eax
Code;  c018e2b3 <find_tcp_session+b3/e0>
   d:   0c 01                     or     $0x1,%al
Code;  c018e2b5 <find_tcp_session+b5/e0>
   f:   85 c0                     test   %eax,%eax
Code;  c018e2b7 <find_tcp_session+b7/e0>
  11:   74 04                     je     17 <_EIP+0x17> c018e2bd <find_tcp_session+bd/e0>
Code;  c018e2b9 <find_tcp_session+b9/e0>
  13:   8b 00                     mov    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000068
c018cb4d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018cb4d>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ecbe9540   ecx: 00000000   edx: c03671f9
esi: cbf9410b   edi: 00000002   ebp: cbf94000   esp: caadbf04
ds: 0068   es: 0068   ss: 0068
Stack: cbf9410b c0367180 00000002 ecbe95a0 cbcc18c0 00000000 00000000 cbcc1600
       cbcc15c0 0000e3f9 efccd140 00000c00 cbf94000 00002000 c017370e cbf94000
       caadbf64 00000000 00000c00 caadbf60 00000000 efccd140 00000000 00000000
Call Trace: [<c017370e>]  [<c0146b0c>]  [<c0146dce>]  [<c01093fb>]
Code: 8b 40 68 89 44 24 18 8b 43 50 89 44 24 1c 8b 43 54 89 44 24


>>EIP; c018cb4d <cifs_debug_data_read+cd/240>   <=====

>>ebx; ecbe9540 <_end+2c76ab4c/3049766c>
>>edx; c03671f9 <large_digits.1+12359/4a040>
>>esi; cbf9410b <_end+bb15717/3049766c>
>>ebp; cbf94000 <_end+bb1560c/3049766c>
>>esp; caadbf04 <_end+a65d510/3049766c>

Trace; c017370e <proc_file_read+be/1c0>
Trace; c0146b0c <vfs_read+dc/150>
Trace; c0146dce <sys_read+3e/60>
Trace; c01093fb <syscall_call+7/b>

Code;  c018cb4d <cifs_debug_data_read+cd/240>
00000000 <_EIP>:
Code;  c018cb4d <cifs_debug_data_read+cd/240>   <=====
   0:   8b 40 68                  mov    0x68(%eax),%eax   <=====
Code;  c018cb50 <cifs_debug_data_read+d0/240>
   3:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  c018cb54 <cifs_debug_data_read+d4/240>
   7:   8b 43 50                  mov    0x50(%ebx),%eax
Code;  c018cb57 <cifs_debug_data_read+d7/240>
   a:   89 44 24 1c               mov    %eax,0x1c(%esp,1)
Code;  c018cb5b <cifs_debug_data_read+db/240>
   e:   8b 43 54                  mov    0x54(%ebx),%eax
Code;  c018cb5e <cifs_debug_data_read+de/240>
  11:   89 44 24 00               mov    %eax,0x0(%esp,1)

Unable to handle kernel NULL pointer dereference at virtual address 00000068
c018cb4d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018cb4d>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ecbe9540   ecx: 00000000   edx: c03671f9
esi: db13010b   edi: 00000002   ebp: db130000   esp: caadbf04
ds: 0068   es: 0068   ss: 0068
Stack: db13010b c0367180 00000002 ecbe95a0 cbcc18c0 00000000 00000000 cbcc1600
       cbcc15c0 0000e3f9 efccd140 00000c00 db130000 00002000 c017370e db130000
       caadbf64 00000000 00000c00 caadbf60 00000000 efccd140 00000000 00000000
Call Trace: [<c017370e>]  [<c0146b0c>]  [<c0146dce>]  [<c01093fb>]
Code: 8b 40 68 89 44 24 18 8b 43 50 89 44 24 1c 8b 43 54 89 44 24


>>EIP; c018cb4d <cifs_debug_data_read+cd/240>   <=====

>>ebx; ecbe9540 <_end+2c76ab4c/3049766c>
>>edx; c03671f9 <large_digits.1+12359/4a040>
>>esi; db13010b <_end+1acb1717/3049766c>
>>ebp; db130000 <_end+1acb160c/3049766c>
>>esp; caadbf04 <_end+a65d510/3049766c>

Trace; c017370e <proc_file_read+be/1c0>
Trace; c0146b0c <vfs_read+dc/150>
Trace; c0146dce <sys_read+3e/60>
Trace; c01093fb <syscall_call+7/b>

Code;  c018cb4d <cifs_debug_data_read+cd/240>
00000000 <_EIP>:
Code;  c018cb4d <cifs_debug_data_read+cd/240>   <=====
   0:   8b 40 68                  mov    0x68(%eax),%eax   <=====
Code;  c018cb50 <cifs_debug_data_read+d0/240>
   3:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  c018cb54 <cifs_debug_data_read+d4/240>
   7:   8b 43 50                  mov    0x50(%ebx),%eax
Code;  c018cb57 <cifs_debug_data_read+d7/240>
   a:   89 44 24 1c               mov    %eax,0x1c(%esp,1)
Code;  c018cb5b <cifs_debug_data_read+db/240>
   e:   8b 43 54                  mov    0x54(%ebx),%eax
Code;  c018cb5e <cifs_debug_data_read+de/240>
  11:   89 44 24 00               mov    %eax,0x0(%esp,1)

Unable to handle kernel NULL pointer dereference at virtual address 00000068
c018cb4d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018cb4d>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ecbe9540   ecx: 00000000   edx: c03671f9
esi: d6ca010b   edi: 00000002   ebp: d6ca0000   esp: caadbf04
ds: 0068   es: 0068   ss: 0068
Stack: d6ca010b c0367180 00000002 ecbe95a0 cbcc18c0 00000000 00000000 cbcc1600
       cbcc15c0 0000e3f9 efccd140 00000c00 d6ca0000 00002000 c017370e d6ca0000
       caadbf64 00000000 00000c00 caadbf60 00000000 efccd140 00000000 00000000
Call Trace: [<c017370e>]  [<c0146b0c>]  [<c0146dce>]  [<c01093fb>]
Code: 8b 40 68 89 44 24 18 8b 43 50 89 44 24 1c 8b 43 54 89 44 24


>>EIP; c018cb4d <cifs_debug_data_read+cd/240>   <=====

>>ebx; ecbe9540 <_end+2c76ab4c/3049766c>
>>edx; c03671f9 <large_digits.1+12359/4a040>
>>esi; d6ca010b <_end+16821717/3049766c>
>>ebp; d6ca0000 <_end+1682160c/3049766c>
>>esp; caadbf04 <_end+a65d510/3049766c>

Trace; c017370e <proc_file_read+be/1c0>
Trace; c0146b0c <vfs_read+dc/150>
Trace; c0146dce <sys_read+3e/60>
Trace; c01093fb <syscall_call+7/b>

Code;  c018cb4d <cifs_debug_data_read+cd/240>
00000000 <_EIP>:
Code;  c018cb4d <cifs_debug_data_read+cd/240>   <=====
   0:   8b 40 68                  mov    0x68(%eax),%eax   <=====
Code;  c018cb50 <cifs_debug_data_read+d0/240>
   3:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  c018cb54 <cifs_debug_data_read+d4/240>
   7:   8b 43 50                  mov    0x50(%ebx),%eax
Code;  c018cb57 <cifs_debug_data_read+d7/240>
   a:   89 44 24 1c               mov    %eax,0x1c(%esp,1)
Code;  c018cb5b <cifs_debug_data_read+db/240>
   e:   8b 43 54                  mov    0x54(%ebx),%eax
Code;  c018cb5e <cifs_debug_data_read+de/240>
  11:   89 44 24 00               mov    %eax,0x0(%esp,1)


1 warning issued.  Results may not be reliable.
--=_-=_-NMOBGDKMHJEGAAAA
Content-Type: text/plain; charset=us-ascii; name="2.5.44ac5ntfsOopses.txt"
Content-Language: en
Content-Length: 3788
Content-Transfer-Encoding: base64

a2VybmVsIEJVRyBhdCBmcy9udGZzL21mdC5jOjI4MSEKaW52YWxpZCBvcGVyYW5kOiAwMDAw
CkNQVTogICAgMApFSVA6ICAgIDAwNjA6WzxmMGEwZDY0OD5dICAgIE5vdCB0YWludGVkClVz
aW5nIGRlZmF1bHRzIGZyb20ga3N5bW9vcHMgLXQgZWxmMzItaTM4NiAtYSBpMzg2CkVGTEFH
UzogMDAwMTMyNDYKZWF4OiBkMGRkNzE0MCAgIGVieDogZDBkZDcxNDAgICBlY3g6IDAwMDAw
MDAxICAgZWR4OiAwMDAwMDAwMAplc2k6IGZmZmZmZmZmICAgZWRpOiBlZmNmNGU4MCAgIGVi
cDogZWVkOWQxNDAgICBlc3A6IGQxMzFmZDE0CmRzOiAwMDY4ICAgZXM6IDAwNjggICBzczog
MDA2OApTdGFjazogZDEwOTdjMzAgZjBhMDYyNDcgZDBkZDcxNDAgZWVmYzAwMDAgZjBhMTJm
ZTAgMDAwMDAwMDUgMDAwMDAwMDkgZDBlM2Q0MjQKICAgICAgIDAxMDAwNDAwIGQwZTNkM2Mw
IGQxMDk2MGEwIGQxMDk2MGMwIDAwMDAwMDAwIGQxMDk2MGJhIGQxMDk2NDQwIGQxMDk2MDAw
CiAgICAgICBlZmNmNGU4MCBkMGUzZDNjMCBkMGRkNzE0MCBkMGUzZDNjMCBlZWQ5ZDE0MCBk
MGUzZDNjMCBkMGUzZDQ1OCBmMGEwYjM2YQpDYWxsIFRyYWNlOiBbPGYwYTA2MjQ3Pl0gIFs8
ZjBhMTJmZTA+XSAgWzxmMGEwYjM2YT5dICBbPGMwMTVlYTYzPl0gIFs8YzAxNWYxZDE+XSAg
WzxmMGEwYWE5OD5dICBbPGYwYTBhODYwPl0gIFs8ZjBhMGE4ZjA+XSAgWzxmMGEwZGU5Mj5d
ICBbPGMwMTVkOWZiPl0gIFs8YzAxNTM2MTQ+XSAgWzxjMDE1Mzg4YT5dICBbPGMwMTUzY2Rk
Pl0gIFs8YzAxNTQ1Mjk+XSAgWzxjMDE0ZmIzYz5dICBbPGMwMTUwMThiPl0gIFs8YzAxMDkz
ZmI+XQpDb2RlOiAwZiAwYiAxOSAwMSBjZiAyOCBhMSBmMCA4NSBkMiA3NSBhOCAwZiAwYiAw
MSAwMSBjZiAyOCBhMSBmMAoKCj4+RUlQOyBmMGEwZDY0OCA8W250ZnNddW5tYXBfbWZ0X3Jl
Y29yZCs1OC83MD4gICA8PT09PT0KCj4+ZWF4OyBkMGRkNzE0MCA8X2VuZCsxMDk1ODc0Yy8z
MDQ5NzY2Yz4KPj5lYng7IGQwZGQ3MTQwIDxfZW5kKzEwOTU4NzRjLzMwNDk3NjZjPgo+PmVz
aTsgZmZmZmZmZmYgPEVORF9PRl9DT0RFK2NmMzRkZjAvPz8/Pz4KPj5lZGk7IGVmY2Y0ZTgw
IDxfZW5kKzJmODc2NDhjLzMwNDk3NjZjPgo+PmVicDsgZWVkOWQxNDAgPF9lbmQrMmU5MWU3
NGMvMzA0OTc2NmM+Cj4+ZXNwOyBkMTMxZmQxNCA8X2VuZCsxMGVhMTMyMC8zMDQ5NzY2Yz4K
ClRyYWNlOyBmMGEwNjI0NyA8W250ZnNdZmluZF9leHRlcm5hbF9hdHRyKzM0Ny81NjA+ClRy
YWNlOyBmMGExMmZlMCA8W250ZnNdLnJvZGF0YS5lbmQrYTg5LzQxNjk+ClRyYWNlOyBmMGEw
YjM2YSA8W250ZnNdbnRmc19yZWFkX2xvY2tlZF9pbm9kZSs0YmEvZmMwPgpUcmFjZTsgYzAx
NWVhNjMgPGFsbG9jX2lub2RlKzE4My8xYjA+ClRyYWNlOyBjMDE1ZjFkMSA8Z2V0X25ld19p
bm9kZStiMS8xMzA+ClRyYWNlOyBmMGEwYWE5OCA8W250ZnNdbnRmc19pZ2V0Kzk4L2IwPgpU
cmFjZTsgZjBhMGE4NjAgPFtudGZzXW50ZnNfdGVzdF9pbm9kZSswLzkwPgpUcmFjZTsgZjBh
MGE4ZjAgPFtudGZzXW50ZnNfaW5pdF9sb2NrZWRfaW5vZGUrMC8xMTA+ClRyYWNlOyBmMGEw
ZGU5MiA8W250ZnNdbnRmc19sb29rdXArZjIvNGYwPgpUcmFjZTsgYzAxNWQ5ZmIgPGRfYWxs
b2MrMThiLzFjMD4KVHJhY2U7IGMwMTUzNjE0IDxyZWFsX2xvb2t1cCtkNC8xMTA+ClRyYWNl
OyBjMDE1Mzg4YSA8ZG9fbG9va3VwKzExYS8xNzA+ClRyYWNlOyBjMDE1M2NkZCA8bGlua19w
YXRoX3dhbGsrM2ZkLzdhMD4KVHJhY2U7IGMwMTU0NTI5IDxfX3VzZXJfd2Fsays0OS82MD4K
VHJhY2U7IGMwMTRmYjNjIDx2ZnNfbHN0YXQrMWMvNjA+ClRyYWNlOyBjMDE1MDE4YiA8c3lz
X2xzdGF0NjQrMWIvNDA+ClRyYWNlOyBjMDEwOTNmYiA8c3lzY2FsbF9jYWxsKzcvYj4KCkNv
ZGU7ICBmMGEwZDY0OCA8W250ZnNddW5tYXBfbWZ0X3JlY29yZCs1OC83MD4KMDAwMDAwMDAg
PF9FSVA+OgpDb2RlOyAgZjBhMGQ2NDggPFtudGZzXXVubWFwX21mdF9yZWNvcmQrNTgvNzA+
ICAgPD09PT09CiAgIDA6ICAgMGYgMGIgICAgICAgICAgICAgICAgICAgICB1ZDJhICAgICAg
PD09PT09CkNvZGU7ICBmMGEwZDY0YSA8W250ZnNddW5tYXBfbWZ0X3JlY29yZCs1YS83MD4K
ICAgMjogICAxOSAwMSAgICAgICAgICAgICAgICAgICAgIHNiYiAgICAlZWF4LCglZWN4KQpD
b2RlOyAgZjBhMGQ2NGMgPFtudGZzXXVubWFwX21mdF9yZWNvcmQrNWMvNzA+CiAgIDQ6ICAg
Y2YgICAgICAgICAgICAgICAgICAgICAgICBpcmV0CkNvZGU7ICBmMGEwZDY0ZCA8W250ZnNd
dW5tYXBfbWZ0X3JlY29yZCs1ZC83MD4KICAgNTogICAyOCBhMSBmMCA4NSBkMiA3NSAgICAg
ICAgIHN1YiAgICAlYWgsMHg3NWQyODVmMCglZWN4KQpDb2RlOyAgZjBhMGQ2NTMgPFtudGZz
XXVubWFwX21mdF9yZWNvcmQrNjMvNzA+CiAgIGI6ICAgYTggMGYgICAgICAgICAgICAgICAg
ICAgICB0ZXN0ICAgJDB4ZiwlYWwKQ29kZTsgIGYwYTBkNjU1IDxbbnRmc111bm1hcF9tZnRf
cmVjb3JkKzY1LzcwPgogICBkOiAgIDBiIDAxICAgICAgICAgICAgICAgICAgICAgb3IgICAg
ICglZWN4KSwlZWF4CkNvZGU7ICBmMGEwZDY1NyA8W250ZnNddW5tYXBfbWZ0X3JlY29yZCs2
Ny83MD4KICAgZjogICAwMSBjZiAgICAgICAgICAgICAgICAgICAgIGFkZCAgICAlZWN4LCVl
ZGkKQ29kZTsgIGYwYTBkNjU5IDxbbnRmc111bm1hcF9tZnRfcmVjb3JkKzY5LzcwPgogIDEx
OiAgIDI4IGExIGYwIDAwIDAwIDAwICAgICAgICAgc3ViICAgICVhaCwweGYwKCVlY3gpCgoK
MSB3YXJuaW5nIGlzc3VlZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4K
--=_-=_-NMOBGDKMHJEGAAAA
Content-Type: text/plain; charset=us-ascii; name="2.5.44ac5smbfsOopses.txt"
Content-Language: en
Content-Length: 8576
Content-Transfer-Encoding: 7bit

kernel BUG at fs/ntfs/mft.c:281!
invalid operand: 0000
CPU:    0
EIP:    0060:[<f0a0d648>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: d0dd7140   ebx: d0dd7140   ecx: 00000001   edx: 00000000
esi: ffffffff   edi: efcf4e80   ebp: eed9d140   esp: d131fd14
ds: 0068   es: 0068   ss: 0068
Stack: d1097c30 f0a06247 d0dd7140 eefc0000 f0a12fe0 00000005 00000009 d0e3d424
       01000400 d0e3d3c0 d10960a0 d10960c0 00000000 d10960ba d1096440 d1096000
       efcf4e80 d0e3d3c0 d0dd7140 d0e3d3c0 eed9d140 d0e3d3c0 d0e3d458 f0a0b36a
Call Trace: [<f0a06247>]  [<f0a12fe0>]  [<f0a0b36a>]  [<c015ea63>]  [<c015f1d1>]  [<f0a0aa98>]  [<f0a0a860>]  [<f0a0a8f0>]  [<f0a0de92>]  [<c015d9fb>]  [<c0153614>]  [<c015388a>]  [<c0153cdd>]  [<c0154529>]  [<c014fb3c>]  [<c015018b>]  [<c01093fb>]
Code: 0f 0b 19 01 cf 28 a1 f0 85 d2 75 a8 0f 0b 01 01 cf 28 a1 f0


>>EIP; f0a0d648 <[ntfs]unmap_mft_record+58/70>   <=====

>>eax; d0dd7140 <_end+1095874c/3049766c>
>>ebx; d0dd7140 <_end+1095874c/3049766c>
>>esi; ffffffff <END_OF_CODE+cf23e50/????>
>>edi; efcf4e80 <_end+2f87648c/3049766c>
>>ebp; eed9d140 <_end+2e91e74c/3049766c>
>>esp; d131fd14 <_end+10ea1320/3049766c>

Trace; f0a06247 <[ntfs]find_external_attr+347/560>
Trace; f0a12fe0 <[ntfs].rodata.end+a89/4169>
Trace; f0a0b36a <[ntfs]ntfs_read_locked_inode+4ba/fc0>
Trace; c015ea63 <alloc_inode+183/1b0>
Trace; c015f1d1 <get_new_inode+b1/130>
Trace; f0a0aa98 <[ntfs]ntfs_iget+98/b0>
Trace; f0a0a860 <[ntfs]ntfs_test_inode+0/90>
Trace; f0a0a8f0 <[ntfs]ntfs_init_locked_inode+0/110>
Trace; f0a0de92 <[ntfs]ntfs_lookup+f2/4f0>
Trace; c015d9fb <d_alloc+18b/1c0>
Trace; c0153614 <real_lookup+d4/110>
Trace; c015388a <do_lookup+11a/170>
Trace; c0153cdd <link_path_walk+3fd/7a0>
Trace; c0154529 <__user_walk+49/60>
Trace; c014fb3c <vfs_lstat+1c/60>
Trace; c015018b <sys_lstat64+1b/40>
Trace; c01093fb <syscall_call+7/b>

Code;  f0a0d648 <[ntfs]unmap_mft_record+58/70>
00000000 <_EIP>:
Code;  f0a0d648 <[ntfs]unmap_mft_record+58/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f0a0d64a <[ntfs]unmap_mft_record+5a/70>
   2:   19 01                     sbb    %eax,(%ecx)
Code;  f0a0d64c <[ntfs]unmap_mft_record+5c/70>
   4:   cf                        iret
Code;  f0a0d64d <[ntfs]unmap_mft_record+5d/70>
   5:   28 a1 f0 85 d2 75         sub    %ah,0x75d285f0(%ecx)
Code;  f0a0d653 <[ntfs]unmap_mft_record+63/70>
   b:   a8 0f                     test   $0xf,%al
Code;  f0a0d655 <[ntfs]unmap_mft_record+65/70>
   d:   0b 01                     or     (%ecx),%eax
Code;  f0a0d657 <[ntfs]unmap_mft_record+67/70>
   f:   01 cf                     add    %ecx,%edi
Code;  f0a0d659 <[ntfs]unmap_mft_record+69/70>
  11:   28 a1 f0 00 00 00         sub    %ah,0xf0(%ecx)

Unable to handle kernel paging request at virtual address f5bcc000
f30d39ef
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<f30d39ef>]    Not tainted
EFLAGS: 00010216
eax: 35bcc000   ebx: c7a39f18   ecx: db985258   edx: f5bcc000
esi: e9698a40   edi: c1138710   ebp: dcfbe6c0   esp: c7a39eec
ds: 0068   es: 0068   ss: 0068
Stack: db985258 00000000 000001d2 00000001 00000000 00000002 00000004 db985258
       00000000 f5bcc000 ee185680 000041ed 00000001 00000000 00000000 00000000
       f5bcc000 00000000 00001000 00000000 00001000 00000008 00000000 e9698a40
Call Trace: [<c0158830>]  [<c0158b40>]  [<c0158cab>]  [<c0158b40>]  [<c0157aa4>]  [<c0157c83>]  [<c01093fb>]
Code: 8b 80 00 00 00 c0 89 44 24 2c 8b 72 04 89 74 24 30 8b 42 08


>>EIP; f30d39ef <[smbfs]smb_readdir+ef/580>   <=====

>>eax; 35bcc000 Before first symbol
>>ebx; c7a39f18 <_end+75bb524/3049766c>
>>ecx; db985258 <_end+1b506864/3049766c>
>>edx; f5bcc000 <END_OF_CODE+2aefe51/????>
>>esi; e9698a40 <_end+2921a04c/3049766c>
>>edi; c1138710 <_end+cb9d1c/3049766c>
>>ebp; dcfbe6c0 <_end+1cb3fccc/3049766c>
>>esp; c7a39eec <_end+75bb4f8/3049766c>

Trace; c0158830 <vfs_readdir+b0/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c0158cab <sys_getdents64+5b/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c0157aa4 <do_fcntl+b4/190>
Trace; c0157c83 <sys_fcntl64+73/c0>
Trace; c01093fb <syscall_call+7/b>

Code;  f30d39ef <[smbfs]smb_readdir+ef/580>
00000000 <_EIP>:
Code;  f30d39ef <[smbfs]smb_readdir+ef/580>   <=====
   0:   8b 80 00 00 00 c0         mov    0xc0000000(%eax),%eax   <=====
Code;  f30d39f5 <[smbfs]smb_readdir+f5/580>
   6:   89 44 24 2c               mov    %eax,0x2c(%esp,1)
Code;  f30d39f9 <[smbfs]smb_readdir+f9/580>
   a:   8b 72 04                  mov    0x4(%edx),%esi
Code;  f30d39fc <[smbfs]smb_readdir+fc/580>
   d:   89 74 24 30               mov    %esi,0x30(%esp,1)
Code;  f30d3a00 <[smbfs]smb_readdir+100/580>
  11:   8b 42 08                  mov    0x8(%edx),%eax

 <1>Unable to handle kernel paging request at virtual address 23c68000
f30d39ef
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<f30d39ef>]    Not tainted
EFLAGS: 00010216
eax: 63c68000   ebx: e0389f18   ecx: db985398   edx: 23c68000
esi: d01d1340   edi: c11221e0   ebp: dcfbe240   esp: e0389eec
ds: 0068   es: 0068   ss: 0068
Stack: db985398 00000000 000001d2 00000001 00000000 00000002 00000004 db985398
       00000000 23c68000 ee185680 000041ed 00000001 00000000 00000000 00000000
       23c68000 00000000 00001000 00000000 00001000 00000008 00000000 d01d1340
Call Trace: [<c0158830>]  [<c0158b40>]  [<c0158cab>]  [<c0158b40>]  [<c0157aa4>]  [<c0157c83>]  [<c01093fb>]
Code: 8b 80 00 00 00 c0 89 44 24 2c 8b 72 04 89 74 24 30 8b 42 08


>>EIP; f30d39ef <[smbfs]smb_readdir+ef/580>   <=====

>>eax; 63c68000 Before first symbol
>>ebx; e0389f18 <_end+1ff0b524/3049766c>
>>ecx; db985398 <_end+1b5069a4/3049766c>
>>edx; 23c68000 Before first symbol
>>esi; d01d1340 <_end+fd5294c/3049766c>
>>edi; c11221e0 <_end+ca37ec/3049766c>
>>ebp; dcfbe240 <_end+1cb3f84c/3049766c>
>>esp; e0389eec <_end+1ff0b4f8/3049766c>

Trace; c0158830 <vfs_readdir+b0/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c0158cab <sys_getdents64+5b/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c0157aa4 <do_fcntl+b4/190>
Trace; c0157c83 <sys_fcntl64+73/c0>
Trace; c01093fb <syscall_call+7/b>

Code;  f30d39ef <[smbfs]smb_readdir+ef/580>
00000000 <_EIP>:
Code;  f30d39ef <[smbfs]smb_readdir+ef/580>   <=====
   0:   8b 80 00 00 00 c0         mov    0xc0000000(%eax),%eax   <=====
Code;  f30d39f5 <[smbfs]smb_readdir+f5/580>
   6:   89 44 24 2c               mov    %eax,0x2c(%esp,1)
Code;  f30d39f9 <[smbfs]smb_readdir+f9/580>
   a:   8b 72 04                  mov    0x4(%edx),%esi
Code;  f30d39fc <[smbfs]smb_readdir+fc/580>
   d:   89 74 24 30               mov    %esi,0x30(%esp,1)
Code;  f30d3a00 <[smbfs]smb_readdir+100/580>
  11:   8b 42 08                  mov    0x8(%edx),%eax

 <1>Unable to handle kernel paging request at virtual address f0342000
f30d39ef
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<f30d39ef>]    Not tainted
EFLAGS: 00010a17
eax: 30342000   ebx: c3d03f18   ecx: c822c518   edx: f0342000
esi: e4cfa640   edi: c1444f58   ebp: c08f28c0   esp: c3d03eec
ds: 0068   es: 0068   ss: 0068
Stack: c822c518 00000000 000001d2 00000001 00000000 0000000a 00000004 c822c518
       00000000 f0342000 ee185680 400e52e0 00000000 00000000 cee140c0 00000000
       f0342000 00030002 00001000 00000000 00001000 00000008 00000000 e4cfa640
Call Trace: [<c0158830>]  [<c0158b40>]  [<c0158cab>]  [<c0158b40>]  [<c013c021>]  [<c01093fb>]
Code: 8b 80 00 00 00 c0 89 44 24 2c 8b 72 04 89 74 24 30 8b 42 08


>>EIP; f30d39ef <[smbfs]smb_readdir+ef/580>   <=====

>>eax; 30342000 Before first symbol
>>ebx; c3d03f18 <_end+3885524/3049766c>
>>ecx; c822c518 <_end+7dadb24/3049766c>
>>edx; f0342000 <_end+2fec360c/3049766c>
>>esi; e4cfa640 <_end+2487bc4c/3049766c>
>>edi; c1444f58 <_end+fc6564/3049766c>
>>ebp; c08f28c0 <_end+473ecc/3049766c>
>>esp; c3d03eec <_end+38854f8/3049766c>

Trace; c0158830 <vfs_readdir+b0/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c0158cab <sys_getdents64+5b/c0>
Trace; c0158b40 <filldir64+0/110>
Trace; c013c021 <sys_brk+101/130>
Trace; c01093fb <syscall_call+7/b>

Code;  f30d39ef <[smbfs]smb_readdir+ef/580>
00000000 <_EIP>:
Code;  f30d39ef <[smbfs]smb_readdir+ef/580>   <=====
   0:   8b 80 00 00 00 c0         mov    0xc0000000(%eax),%eax   <=====
Code;  f30d39f5 <[smbfs]smb_readdir+f5/580>
   6:   89 44 24 2c               mov    %eax,0x2c(%esp,1)
Code;  f30d39f9 <[smbfs]smb_readdir+f9/580>
   a:   8b 72 04                  mov    0x4(%edx),%esi
Code;  f30d39fc <[smbfs]smb_readdir+fc/580>
   d:   89 74 24 30               mov    %esi,0x30(%esp,1)
Code;  f30d3a00 <[smbfs]smb_readdir+100/580>
  11:   8b 42 08                  mov    0x8(%edx),%eax
--=_-=_-NMOBGDKMHJEGAAAA--

