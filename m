Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUFRQib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUFRQib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUFRQib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:38:31 -0400
Received: from macvin.cri2000.ens-lyon.fr ([140.77.13.55]:50828 "EHLO
	macvin.cri2000.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S265258AbUFRQiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:38:06 -0400
Date: Fri, 18 Jun 2004 18:37:59 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7 Samba OOPS (in smb_readdir)
Message-ID: <20040618163759.GN1146@ens-lyon.fr>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
X-Operating-System: Linux 2.6.7 i686
Organization: Ecole Normale Superieure de Lyon
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I am using Samba on my Compaq Evo N600c with an uptodate Debian
Testing and a 2.6.7 (.config attached).

When listing a samba mount point just after mounting it, 
I get this oops. I don't know why nautilus is used here, I
just called 'ls'.

I get the same oops with 2.6.7-rc3 (can't try previous releases).

Regards.

Brice Goglin



smb_lookup: find //.Trash-bgoglin failed, error=-5
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: dm_mod
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246   (2.6.7) 
EIP is at 0x0
eax: dfc21ccc   ebx: e160cf30   ecx: c01684c0   edx: e7fa4bd8
esi: e160cfa0   edi: c13f0780   ebp: df839740   esp: e160cefc
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 2649, threadinfo=e160c000 task=e101f3d0)
Stack: c01f1536 df839740 e160cfa0 c01684c0 e160cf30 00000000 00000002 00000004 
       df7faeb0 00000000 df83c000 e7fa4bd8 df8acbe0 00000000 fffd18ab 00000000 
       00000000 00000000 df83c000 00000002 00000000 00000000 00000001 00000004 
Call Trace:
[<c01f1536>] smb_readdir+0x3e6/0x580
[<c01684c0>] filldir64+0x0/0x100
[<c01681b9>] vfs_readdir+0x89/0xa0
[<c01684c0>] filldir64+0x0/0x100
[<c016862e>] sys_getdents64+0x6e/0xaa
[<c01684c0>] filldir64+0x0/0x100
[<c010510b>] syscall_call+0x7/0xb
       
  Code:  Bad EIP value.
       


On 16/06/2004-08:00, Linus Torvalds wrote:

> 
> Ok, it's out there. The most notable change may be the one-liner that 
> should fix the embarrassing FP exception problem. Other than that, we've 
> had a random collection of fixes and updates since rc3. cifs, ntfs, 
> cpufreq. ide, sparc, s390.
> 
> Full 2.6.6->2.6.7 changelog available at the same places the release is.
> 
> 		Linus
