Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131603AbQKTKOI>; Mon, 20 Nov 2000 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbQKTKN6>; Mon, 20 Nov 2000 05:13:58 -0500
Received: from proxy.ovh.net ([213.244.20.42]:30474 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S131519AbQKTKNr>;
	Mon, 20 Nov 2000 05:13:47 -0500
Message-ID: <3A18F244.29E519C4@ovh.net>
Date: Mon, 20 Nov 2000 10:43:32 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: oops 2.2.17-RAID
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Running on 2.2.17 raid-soft 1 (2940u2w 2x18Go).
I had a problem on a hard disk (in /proc/mdstat sdb has a f)
So I raidhotremoved the sdb and raidhotadding sdb I had
a kernel panic.
Is it raid or kernel problem ?

Octave


Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 0246f000, %cr3 = 0246f000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000246   ecx: 00000001   edx: c0236920
esi: c2995eb0   edi: cb9394e0   ebp: c2994000   esp: c2995e90
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 586, process nr: 68, stackpage=c2995000)
Stack: c0123a0e c0236920 0024003d 00000900 cb43f320 00038100 c2995eb0 c2995eb0 
       c2994000 cb93950c c01247e2 cb9394e0 cb9394e0 c013d2bd 00000900 0024003d 
       00001000 cb43f320 c02282c0 cb43f328 c02282c0 ffffffe4 cfcbca00 00000048 
Call Trace: [<c0123a0e>] [<c01247e2>] [<c013d2bd>] [<c012f555>] [<c012f6bc>] [<c013e008>] [<c0129813>] 
       [<c0129a10>] [<c0129af8>] [<c0127b52>] [<c01079bc>] 
Code: Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0123a0e <__wait_on_buffer+86/d4>
Trace; c01247e2 <bread+4a/70>
Trace; c013d2bd <ext2_read_inode+e9/3d8>
Trace; c012f555 <get_new_inode+99/118>
Trace; c012f6bc <iget+58/60>
Trace; c013e008 <ext2_lookup+54/7c>
Trace; c0129813 <real_lookup+4f/a0>
Trace; c0129a10 <lookup_dentry+128/1e8>
Trace; c0129af8 <__namei+28/58>
Trace; c0127b52 <sys_newstat+e/60>
Trace; c01079bc <system_call+34/38>


3 warnings issued.  Results may not be reliable.
-- 
Amicalement,
oCtAvE 
______________________ lA réVoLutIon AurA bIen LIeu ____
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
