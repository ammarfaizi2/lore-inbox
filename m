Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291062AbSBLOOO>; Tue, 12 Feb 2002 09:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291069AbSBLOOF>; Tue, 12 Feb 2002 09:14:05 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:4872
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S291062AbSBLONx>; Tue, 12 Feb 2002 09:13:53 -0500
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  hpfs bug
From: Shawn Starr <spstarr@sh0n.net>
To: Dag Bakke <dag@bakke.com>
Cc: Linux <linux-kernel@vger.kernel.org>, xfs <linux-xfs@oss.sgi.com>
In-Reply-To: <20020212140036.A223@dagb>
In-Reply-To: <20020212140036.A223@dagb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Feb 2002 09:16:10 -0500
Message-Id: <1013523397.263.6.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some others have reported problems with superblock reading on boot.
There may be some code that has changed superblock reading but this
might be different.

Shawn.


On Tue, 2002-02-12 at 08:00, Dag Bakke wrote:
> Hi.
> 
> Compiling in support for hpfs in 2.4.18-pre9-xfs-shawn4 causes panic on
> boot.
> (I do have a some devicedriver patches added to your patch, but nothing related to
> core, vfs or hpfs.)
> 
> Thanks,
> 
> Dag B
> 
> 
> root@dagb:~# ksymoops -L -m /boot/System.map -K <~dagb/kernelcrash.txt 
> ksymoops 2.4.3 on i686 2.4.18-pre9-xfs-shawn4.  Options used
>      -V (default)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.18-pre9-xfs-shawn4/ (default)
>      -m /boot/System.map (specified)
> 
> No modules in ksyms, skipping objects
> invalid operand:        0000
> CPU:    0
> EIP:  0010:[<c0136d10>] Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> >>EIP; c0136d10 <grow_buffers+50/100>   <=====
> 
> Stack:  00000302  00000000  00000000  c13a91c0  00002240  c0134eb7  00000302  00000000
>         00000000  cffe7ed8  cfe6a000  cfe6a044  c01350aa  00000302  00000000  00000000
>         cffe7ed8  cfe6a000  c13a91c0  c019e96c  00000302  00000000  00000000  00000000
> Call Trace: [<c0134eb7>] [<c01350aa>] [<c019e96e>] [<c01a7a8d>] [<c01378a9>] [<c0137c27>] [<c010503a>] [<c010504c>] [<c01054e8>]
> Code: 0f 0b b9 ff ff ff ff 89 fa b6 00 90 8d 74 26 06 8b 44 24 20
> 
> Trace; c0134eb6 <getblk+26/40>
> Trace; c01350aa <bread+1a/c0>
> Trace; c019e96e <hpfs_map_sector+1e/40>
> Trace; c01a7a8c <hpfs_read_super+15c/730>
> Trace; c01378a8 <insert_super+38/40>
> Trace; c0137c26 <read_super+56/b0>
> Trace; c010503a <prepare_namespace+a/10>
> Trace; c010504c <init+c/110>
> Trace; c01054e8 <kernel_thread+28/40>
> Code;  c0136d10 <grow_buffers+50/100>
> 00000000 <_EIP>:
> Code;  c0136d10 <grow_buffers+50/100>
>    0:   0f 0b                     ud2a   
> Code;  c0136d12 <grow_buffers+52/100>
>    2:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
> Code;  c0136d16 <grow_buffers+56/100>
>    7:   89 fa                     mov    %edi,%edx
> Code;  c0136d18 <grow_buffers+58/100>
>    9:   b6 00                     mov    $0x0,%dh
> Code;  c0136d1a <grow_buffers+5a/100>
>    b:   90                        nop    
> Code;  c0136d1c <grow_buffers+5c/100>
>    c:   8d 74 26 06               lea    0x6(%esi,1),%esi
> Code;  c0136d20 <grow_buffers+60/100>
>   10:   8b 44 24 20               mov    0x20(%esp,1),%eax
> 
> 
> 1 warning issued.  Results may not be reliable.
> 


