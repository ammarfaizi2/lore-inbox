Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280107AbRJaIwI>; Wed, 31 Oct 2001 03:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRJaIv7>; Wed, 31 Oct 2001 03:51:59 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:29368 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S280107AbRJaIvr>; Wed, 31 Oct 2001 03:51:47 -0500
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Simon Kirby <sim@netnation.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre4 tainted + preempt oops...
In-Reply-To: <Pine.LNX.4.33.0110301502390.1188-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 31 Oct 2001 09:52:08 +0100
In-Reply-To: <Pine.LNX.4.33.0110301502390.1188-100000@penguin.transmeta.com>
Message-ID: <m3668wfayv.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, 30 Oct 2001, Linus Torvalds wrote:
> Can you send me the oops? 2.4.12 may not be the best kernel ever
> released, but I don't think it was fundamentally broken
> either. Maybe the oops will remind me about something..

I did report the appended oops on 2.4.12. Similar oopses happened
again several times on the same kernel. I upgraded to 2.4.13 and it
went away.

Greetings
		Christoph


ksymoops 2.3.5 on i686 2.4.12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12/ (default)
     -m /boot/System.map-2.4.12 (specified)

Warning (compare_maps): mismatch on symbol floppy  , floppy says d0b8a1d8, /lib/modules/2.4.12/kernel/drivers/block/floppy.o says d0b89558.  Ignoring /lib/modules/2.4.12/kernel/drivers/block/floppy.o entry
Unable to handle kernel paging request at virtual address f902a6a8
c012fcb1
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012fcb1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: f902a6a4   ebx: c007f6e0   ecx: 000003d2   edx: e3480040
esi: c007f6e0   edi: c007f6e0   ebp: c1134c80   esp: c2ba1dd8
ds: 0018   es: 0018   ss: 0018
Process mozilla-bin (pid: 12020, stackpage=c2ba1000)
Stack: c0131f5c c007f6e0 c025e9c8 c1134c80 00000014 00000884 c012828a c1134c80 
       000003d2 00000020 000003d2 00000006 00000020 c2ba0000 c025e9c8 c0128648 
       000003d2 00000007 00000006 00000020 000003d2 c025e9c8 c025e9c8 c012869c 
Call Trace: [<c0131f5c>] [<c012828a>] [<c0128648>] [<c012869c>] [<c01291af>] 
   [<c01294cc>] [<c0129146>] [<c01204b1>] [<c012053f>] [<c0120637>] [<c0110908>] 
   [<c01107a8>] [<d0b1f1c5>] [<c0121824>] [<c011767a>] [<c0116f29>] [<c0106c1c>] 
Code: 89 50 04 89 02 c3 90 8b 54 24 04 31 c9 8d 42 18 39 42 18 75 

>>EIP; c012fcb1 <__remove_inode_queue+11/18>   <=====
Trace; c0131f5c <try_to_free_buffers+70/14c>
Trace; c012828a <shrink_cache+15e/34c>
Trace; c0128648 <shrink_caches+60/88>
Trace; c012869c <try_to_free_pages+2c/6c>
Trace; c01291af <balance_classzone+67/254>
Trace; c01294cc <__alloc_pages+130/1ac>
Trace; c0129146 <_alloc_pages+16/18>
Trace; c01204b1 <do_anonymous_page+35/94>
Trace; c012053f <do_no_page+2f/cc>
Trace; c0120637 <handle_mm_fault+5b/c4>
Trace; c0110908 <do_page_fault+160/498>
Trace; c01107a8 <do_page_fault+0/498>
Trace; d0b1f1c5 <[snd-cs461x]snd_cs461x_interrupt+1b5/1c0>
Trace; c0121824 <do_brk+118/1fc>
Trace; c011767a <do_softirq+5a/a4>
Trace; c0116f29 <sys_gettimeofday+21/134>
Trace; c0106c1c <error_code+34/3c>
Code;  c012fcb1 <__remove_inode_queue+11/18>
00000000 <_EIP>:
Code;  c012fcb1 <__remove_inode_queue+11/18>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012fcb4 <__remove_inode_queue+14/18>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012fcb6 <__remove_inode_queue+16/18>
   5:   c3                        ret    
Code;  c012fcb7 <__remove_inode_queue+17/18>
   6:   90                        nop    
Code;  c012fcb8 <inode_has_buffers+0/20>
   7:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c012fcbc <inode_has_buffers+4/20>
   b:   31 c9                     xor    %ecx,%ecx
Code;  c012fcbe <inode_has_buffers+6/20>
   d:   8d 42 18                  lea    0x18(%edx),%eax
Code;  c012fcc1 <inode_has_buffers+9/20>
  10:   39 42 18                  cmp    %eax,0x18(%edx)
Code;  c012fcc4 <inode_has_buffers+c/20>
  13:   75 00                     jne    15 <_EIP+0x15> c012fcc6 <inode_has_buffers+e/20>


1 warning issued.  Results may not be reliable.

