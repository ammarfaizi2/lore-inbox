Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRDFQBd>; Fri, 6 Apr 2001 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRDFQBY>; Fri, 6 Apr 2001 12:01:24 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:57874
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131806AbRDFQBK>; Fri, 6 Apr 2001 12:01:10 -0400
Date: Fri, 06 Apr 2001 11:00:12 -0500
From: Chris Mason <mason@suse.com>
To: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: gcc oopses with 2.4.3
Message-ID: <123100000.986572812@tiny>
In-Reply-To: <20010406174442.A19874@alpha.logic.tuwien.ac.at>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, April 06, 2001 05:44:42 PM +0200 Norbert Preining
<preining@logic.at> wrote:

> Hi!
> 
> I get frequent `internal compiler error', killed with Sig 4  or Sig 11
> and sometimes Ooops from compiling X or kernel. 
> 
> System: 2.4.3-vanilla, reiserfs, glibc-2.1.3
> [~] gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> 
> 
> Here a decoded Ooops:
> 
> ksymoops 0.7c on i586 2.4.3.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.3/ (default)
>      -m /boot/System.map-2.4.3 (specified)
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 c0145e41
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[ext2_new_block+317/1808]
> EFLAGS: 00010282
> eax: 00000000   ebx: c7261de8   ecx: 00000000   edx: 00000000
> esi: c6dab000   edi: 00000000   ebp: c7261dec   esp: c7261d9c
> ds: 0018   es: 0018   ss: 0018
> Process cc1 (pid: 20767, stackpage=c7261000)
> Stack: c2f280e0 00000001 c7261e3c 00000001 c01675d0 00000000 00000000
> c6dab038  c6dab034 c7261e7c c7261e94 c020e91c 00000001 00000009 00000008
>        c7cc7c00  c1265800 00000000 c473c9e0 c1264120 c7261e40 c014755c
>        c2f280e0 00000001  Call Trace: [search_by_key+2028/3140]
> [ext2_alloc_block+120/128] [ext2_alloc_branch+41/456]
> [ext2_get_block+695/1152] [create_empty_buffers+23/108]
> [__block_prepare_write+234/560] [block_prepare_write+29/52]  Code: 74 04
> 31 d2 eb 52 83 be c8 00 00 00 08 77 20 8d 04 bd 00 00  Using defaults
> from ksymoops -t elf32-i386 -a i386

Neat, looks like you've installed the all new extreiser2fs.  Really though,
do you have ext2 on the box at all?

sigbus from gcc usually points to the ram, have you run a tester?

-chris

