Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289541AbSAJQsq>; Thu, 10 Jan 2002 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289543AbSAJQsg>; Thu, 10 Jan 2002 11:48:36 -0500
Received: from [62.98.202.87] ([62.98.202.87]:260 "EHLO
	gandalf.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S289539AbSAJQsa>; Thu, 10 Jan 2002 11:48:30 -0500
Date: Thu, 10 Jan 2002 17:44:17 +0100 (CET)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18pre2 oops using agpgart
Message-ID: <Pine.LNX.4.33.0201101742380.219-100000@gandalf.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It finally turned out that using the agpgart module with my notebook makes
my machine crash and reset. Here's the last oops :

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c012f857
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f857>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: ca5e3a80   ecx: 00000000   edx: c0254f34
esi: 00000000   edi: ffffffe9   ebp: c14062e0   esp: c9a6bf54
ds: 0018   es: 0018   ss: 0018
Process fetchmail (pid: 3134, stackpage=c9a6b000)
Stack: bfffeebc ffffffe9 c012e73a bfffeebc cc8c8000 00000000 bfffeeac c012e71a
       cf6902e0 c14062e0 00000000 00000003 cc8c8000 bffff624 cf6902e0 c14062e0
       bffff624 bfffeeac 00000000 00000001 00000001 c012ea4a cc8c8000 00000000
Call Trace: [<c012e73a>] [<c012e71a>] [<c012ea4a>] [<c0106b0b>]
Code: 89 50 04 89 02 ff 0d 24 4f 25 c0 31 c0 b9 1a 00 00 00 89 df
Error (Oops_bfd_perror): set_section_contents Bad value

>>EIP; c012f856 <get_empty_filp+16/108>   <=====
Trace; c012e73a <dentry_open+16/188>
Trace; c012e71a <filp_open+52/5c>
Trace; c012ea4a <sys_open+36/94>
Trace; c0106b0a <system_call+32/38>

I've seen many of these oops. Please help.

Cristiano

----
GnuPG Public Key Fingerprint (certserver.pgp.com)
pub  1024D/BF762716 2002-01-08 Cristiano Paris (privata) <c.paris@libero.it>
     Key fingerprint = 91BA C55F 4B75 730D 5FB3  16AB 4202 9ACA BF76 2716

