Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155161AbQD0Qbw>; Thu, 27 Apr 2000 12:31:52 -0400
Received: by vger.rutgers.edu id <S155199AbQD0Q2r>; Thu, 27 Apr 2000 12:28:47 -0400
Received: from hplms26.hpl.hp.com ([15.255.168.31]:1793 "EHLO hplms26.hpl.hp.com") by vger.rutgers.edu with ESMTP id <S155229AbQD0QT6>; Thu, 27 Apr 2000 12:19:58 -0400
Date: Thu, 27 Apr 2000 09:25:52 -0700
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
To: Linux kernel mailing list <linux-kernel@vger.rutgers.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: My computer doesn't like 2.3.X [2.3.99-pre6 still flaky]
Message-ID: <20000427092552.B19008@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20000317170951.A5703@bougret.hpl.hp.com> <20000426125056.A12819@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000426125056.A12819@bougret.hpl.hp.com>; from jt on Wed, Apr 26, 2000 at 12:50:56PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Apr 26, 2000 at 12:50:56PM -0700, Jean Tourrilhes wrote:
>
> 	2d) If I do some kernel compilation, big ftp or other stuff, I
> can also crash the box without effort. Oops look the same.

	Full of hopes, I did upgrade to the latest kernel
(2.3.99-pre6). The kernel seems sligthly better, but it is still
ridiculously easy to crash.

	Let say that I have a directory with a few kernel tarballs (in
tar.gz form), or probably anything else big (few dozen MB). One kernel
is not enough, but 2 will do nicely. Add a few more kernels if you
have more RAM or just to make sure...
	If I do :
--------
ftp 127.0.0.1
cd kernels
prompt
mget *
--------
	I get :
--------------------------------
stack segment: 0000
CPU:    0
EIP:    0010:[kmem_cache_grow+811/1036]
EFLAGS: 00010296
eax: 00000073   ebx: c00edfe0   ecx: 00000000   edx: 0000001d
esi: c11279e0   edi: c00ed060   ebp: ffffffff   esp: c3155de8
ds: 0018   es: 0018   ss: 0018
Process wu-ftpd (pid: 201, stackpage=c3155000)
Stack: c11279e8 c11279e0 00000003 00000282 c00ed158 c11279e8 c00ed060 0000001d 
       00000000 00000202 00000001 00000003 00000060 c0125f8b c11279e0 00000003 
       c0225f00 00000000 c0225f00 00000400 c012cecd c11279e0 00000003 c0225f00 
Call Trace: [kmem_cache_alloc+375/456] [get_unused_buffer_head+57/184] [create_buffers+32/784] [create_empty_buffers+24/112] [block_read_full_page+92/532] [add_to_page_cache_unique+205/316] [ext2_readpage+15/20] 
       [ext2_get_block+0/1164] [generic_file_readahead+522/728] [do_generic_file_read+644/1244] [generic_file_read+99/128] [file_read_actor+0/136] [sys_read+192/224] [system_call+52/56] [startup_32+43/309] 
Code: 89 45 00 8b 6d 00 83 6c 24 1c 01 0f 83 04 ff ff ff c7 45 00 
--------------------------------

	That's all...

	Jean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
