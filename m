Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283234AbRLDSff>; Tue, 4 Dec 2001 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283221AbRLDSeP>; Tue, 4 Dec 2001 13:34:15 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:58426 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281527AbRLDScl> convert rfc822-to-8bit; Tue, 4 Dec 2001 13:32:41 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Oops: 0000 with kernel 2.4.17pre2
Date: Tue, 4 Dec 2001 19:31:09 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E16BKMt-0004SE-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found this in my logs.
I have no idea, why the log says not tainted, because I am quite sure that 
the nvidia-driver was loaded at this moment.
It seems that this happened while trying to kill a quake3-session.(I noticed 
today, that there is a linux version..... ;-))

I don´t know if I should blame the nvidia-driver, but please have a look at 
it, because there were some other oops messages with 2.4.16 in the LKML.
The call trace has functions of the VM, of the file system layer and reiserfs.


greetings

Christian Bornträger

Dec  4 16:46:33 cubus kernel:  printing eip:
Dec  4 16:46:33 cubus kernel: e09677f5
Dec  4 16:46:33 cubus kernel: Oops: 0000
Dec  4 16:46:33 cubus kernel: CPU:    0
Dec  4 16:46:33 cubus kernel: EIP:    0010:[<e09677f5>]    Not tainted
Dec  4 16:46:33 cubus kernel: EFLAGS: 00010a86
Dec  4 16:46:33 cubus kernel: eax: c9dfb8c0   ebx: 5f656c70   ecx: ca1c6140   
edx: c8ead8cf
Dec  4 16:46:33 cubus kernel: esi: c9dfb8c0   edi: 00000000   ebp: cda57b20   
esp: cda57b08
Dec  4 16:46:33 cubus kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 16:46:33 cubus kernel: Process quake3.x86 (pid: 17799, 
stackpage=cda57000)
Dec  4 16:46:33 cubus kernel: Stack: cda57b0c 00000102 cda57b40 c9dfbec0 
cda57c3c e0a049a0 cda57b50 e0965744
Dec  4 16:46:33 cubus kernel:        cda57c24 00000102 cda57bd4 c1d0003e 
cda57b48 e096a101 00000000 00000002
Dec  4 16:46:33 cubus kernel:        00002100 00000001 cda57b70 e0967c3d 
e0a049a0 cda57c24 00000102 00000001
Dec  4 16:46:33 cubus kernel: Call Trace: [<e0a049a0>] [<e0965744>] 
[<e096a101>] [<e0967c3d>] [<e0a049a0>]
Dec  4 16:46:33 cubus kernel:    [<e096ca1b>] [<e096c839>] [<e09694bc>] 
[filemap_nopage+233/512] [do_page_fault+0/1200] [do_no_page+77/256]
Dec  4 16:46:33 cubus kernel:    [<e096ca1b>] [<e096c839>] [<e09694bc>] 
[<c01252b9>] [<c0111470>] [<c0121e3d>]
Dec  4 16:46:33 cubus kernel:    [handle_mm_fault+88/192] 
[do_page_fault+382/1200] [__alloc_pages+63/384] [do_anonymous_page+126/160] 
[do_no_page+49/256] [unix_write_space+55/112]
Dec  4 16:46:33 cubus kernel:    [<c0121f48>] [<c01115ee>] [<c012abef>] 
[<c0121dce>] [<c0121e21>] [<c020cbc7>]
Dec  4 16:46:33 cubus kernel:    [sock_def_readable+41/96] 
[__alloc_pages+63/384] [filemap_nopage+187/512] [fast_clear_page+10/96] 
[do_anonymous_page+126/160] [kfree_skbmem+11/96]
Dec  4 16:46:33 cubus kernel:    [<c01d98c9>] [<c012abef>] [<c012528b>] 
[<c0212d8a>] [<c0121dce>] [<c01d9e1b>]
Dec  4 16:46:33 cubus kernel:    [do_no_page+49/256] [handle_mm_fault+88/192] 
[<e09640bb>] [<e09648ba>] [<e0a049a0>] [do_page_fault+382/1200]
Dec  4 16:46:33 cubus kernel:    [<c0121e21>] [<c0121f48>] [<e09640bb>] 
[<e09648ba>] [<e0a049a0>] [<c01115ee>]
Dec  4 16:46:33 cubus kernel:    [dentry_open+227/384] [filp_open+73/96] 
[getname+93/160] [sys_ioctl+374/400] [system_call+51/56]
Dec  4 16:46:33 cubus kernel:    [<c012faf3>] [<c012f9f9>] [<c013861d>] 
[<c013c156>] [<c0106cfb>]
Dec  4 16:46:33 cubus kernel:
Dec  4 16:46:33 cubus kernel: Code: 8b 43 18 29 d0 3b 45 0c 72 c1 89 5e 04 89 
4e 08 8b 41 04 89
Dec  4 16:48:12 cubus kernel:  <6>NVRM: AGPGART: freed 16 pages
Dec  4 16:48:14 cubus kernel:  printing eip:
Dec  4 16:48:14 cubus kernel: e097134a
Dec  4 16:48:14 cubus kernel: Oops: 0000
Dec  4 16:48:14 cubus kernel: CPU:    0
Dec  4 16:48:14 cubus kernel: EIP:    0010:[<e097134a>]    Not tainted
Dec  4 16:48:14 cubus kernel: EFLAGS: 00013056
Dec  4 16:48:14 cubus kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   
edx: df463744
Dec  4 16:48:14 cubus kernel: esi: e5a33004   edi: 00000000   ebp: df977ae8   
esp: df977ad4
Dec  4 16:48:14 cubus kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 16:48:14 cubus kernel: Process X (pid: 17828, stackpage=df977000)
Dec  4 16:48:14 cubus kernel: Stack: 00000000 e5a33004 00000010 00008000 
00000000 df977b10 e09717fd e5a33004
Dec  4 16:48:14 cubus kernel:        00000010 df977b08 ce2f6680 df977c3c 
e0a049a0 dcc89000 df463744 df977b50
Dec  4 16:48:14 cubus kernel:        e09657a5 e5a33004 df977c24 00000010 
00000041 df977bd4 00000000 00000028
Dec  4 16:48:14 cubus kernel: Call Trace: [<e09717fd>] [<e0a049a0>] 
[<e09657a5>] [<e096a101>] [<e0967c3d>]
Dec  4 16:48:14 cubus kernel:    [<e0a049a0>] [<e096ca1b>] [<e096c839>] 
[<e09694bc>] [getblk+24/64] [is_tree_node+65/96]
Dec  4 16:48:14 cubus kernel:    [<e0a049a0>] [<e096ca1b>] [<e096c839>] 
[<e09694bc>] [<c0131db8>] [<c0184181>]
Dec  4 16:48:14 cubus kernel:    [search_by_key+2114/3152] 
[check_journal_end+500/544] [bread+34/128] [getblk+24/64] [bread+34/128] 
[is_tree_node+65/96]
Dec  4 16:48:14 cubus kernel:    [<c01849e2>] [<c018be64>] [<c0131fd2>] 
[<c0131db8>] [<c0131fd2>] [<c0184181>]
Dec  4 16:48:14 cubus kernel:    [search_by_key+2114/3152] [pathrelse+31/48] 
[make_cpu_key+47/64] [pathrelse+31/48] [do_journal_end+193/2816] 
[generic_commit_write+50/96]
Dec  4 16:48:14 cubus kernel:    [<c01849e2>] [<c0183f7f>] [<c017656f>] 
[<c0183f7f>] [<c018c331>] [<c0132da2>]
Dec  4 16:48:14 cubus kernel:    [reiserfs_commit_write+142/176] [<e09648ba>] 
[<e0a049a0>] [generic_file_write+1214/1632] [generic_file_write+1310/1632] 
[write_chan+0/496]
Dec  4 16:48:14 cubus kernel:    [<c01798fe>] [<e09648ba>] [<e0a049a0>] 
[<c012671e>] [<c012677e>] [<c0198630>]
Dec  4 16:48:14 cubus kernel:    [old_mmap+274/288] [sys_ioctl+374/400] 
[system_call+51/56]
Dec  4 16:48:14 cubus kernel:    [<c010b202>] [<c013c156>] [<c0106cfb>]
Dec  4 16:48:14 cubus kernel:
Dec  4 16:48:14 cubus kernel: Code: 80 3c 38 00 75 08 83 c3 07 e9 88 00 00 00 
89 d8 c1 e8 03 8b
Dec  4 16:48:32 cubus kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Dec  4 16:48:32 cubus kernel:  printing eip:
Dec  4 16:48:32 cubus kernel: e097134a
Dec  4 16:48:32 cubus kernel: Oops: 0000
Dec  4 16:48:32 cubus kernel: CPU:    0
Dec  4 16:48:32 cubus kernel: EIP:    0010:[<e097134a>]    Not tainted
Dec  4 16:48:32 cubus kernel: EFLAGS: 00013056
Dec  4 16:48:32 cubus kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   
edx: dc431384
Dec  4 16:48:32 cubus kernel: esi: e5a33004   edi: 00000000   ebp: c35e5ae8   
esp: c35e5ad4
Dec  4 16:48:32 cubus kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 16:48:32 cubus kernel: Process X (pid: 17868, stackpage=c35e5000)
Dec  4 16:48:32 cubus kernel: Stack: 00000000 e5a33004 00000010 00008000 
00000000 c35e5b10 e09717fd e5a33004
Dec  4 16:48:32 cubus kernel:        00000010 c35e5b08 ce2f6240 c35e5c3c 
e0a049a0 dcc89000 dc431384 c35e5b50
Dec  4 16:48:32 cubus kernel:        e09657a5 e5a33004 c35e5c24 00000010 
00000041 c35e5bd4 00000000 00000028
Dec  4 16:48:32 cubus kernel: Call Trace: [<e09717fd>] [<e0a049a0>] 
[<e09657a5>] [<e096a101>] [<e0967c3d>]
Dec  4 16:48:32 cubus kernel:    [<e0a049a0>] [<e096ca1b>] [<e096c839>] 
[<e09694bc>] [getblk+24/64] [is_tree_node+65/96]
Dec  4 16:48:32 cubus kernel:    [<e0a049a0>] [<e096ca1b>] [<e096c839>] 
[<e09694bc>] [<c0131db8>] [<c0184181>]
Dec  4 16:48:32 cubus kernel:    [search_by_key+2114/3152] 
[check_journal_end+500/544] [bread+34/128] [getblk+24/64] [bread+34/128] 
[is_tree_node+65/96]
Dec  4 16:48:32 cubus kernel:    [<c01849e2>] [<c018be64>] [<c0131fd2>] 
[<c0131db8>] [<c0131fd2>] [<c0184181>]
Dec  4 16:48:32 cubus kernel:    [search_by_key+2114/3152] [pathrelse+31/48] 
[make_cpu_key+47/64] [pathrelse+31/48] [do_journal_end+193/2816] 
[generic_commit_write+50/96]
Dec  4 16:48:32 cubus kernel:    [<c01849e2>] [<c0183f7f>] [<c017656f>] 
[<c0183f7f>] [<c018c331>] [<c0132da2>]
Dec  4 16:48:32 cubus kernel:    [reiserfs_commit_write+142/176] [<e09648ba>] 
[<e0a049a0>] [generic_file_write+1214/1632] [generic_file_write+1310/1632] 
[write_chan+0/496]
Dec  4 16:48:32 cubus kernel:    [<c01798fe>] [<e09648ba>] [<e0a049a0>] 
[<c012671e>] [<c012677e>] [<c0198630>]
Dec  4 16:48:32 cubus kernel:    [old_mmap+274/288] [sys_ioctl+374/400] 
[system_call+51/56]
Dec  4 16:48:32 cubus kernel:    [<c010b202>] [<c013c156>] [<c0106cfb>]
Dec  4 16:48:32 cubus kernel:
Dec  4 16:48:32 cubus kernel: Code: 80 3c 38 00 75 08 83 c3 07 e9 88 00 00 00 
89 d8 c1 e8 03 8b
