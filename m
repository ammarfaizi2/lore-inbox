Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284042AbRLAKBw>; Sat, 1 Dec 2001 05:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284041AbRLAKBn>; Sat, 1 Dec 2001 05:01:43 -0500
Received: from [193.252.19.61] ([193.252.19.61]:1698 "EHLO mel-rta7.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S284040AbRLAKB2>;
	Sat, 1 Dec 2001 05:01:28 -0500
Message-ID: <3C08AA05.C3218C82@wanadoo.fr>
Date: Sat, 01 Dec 2001 10:59:33 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
			<9u9qas$1eo$1@penguin.transmeta.com> <200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Oops comes after starting devfsd by hand, it is possibly more
reliable than the previous one :

Unable to handle kernel paging request at virtual address 5a5a5a5e 
 printing eip: 
c01516f9 
*pde = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0010:[devfs_put+13/188]    Tainted: P  
EFLAGS: 00013206 
eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000016   edx: 5a5a5a5a 
esi: 00000000   edi: 00000026   ebp: 00000000   esp: cf631f40 
ds: 0018   es: 0018   ss: 0018 
Process devfsd (pid: 144, stackpage=cf631000) 
Stack: 00000026 c015419c 5a5a5a5a cf96ba34 ffffffea 00000000 00000420
cfb80800  
c01e7200 cf4f2240 5a5a5a5a 000003fa 00000000 00000000 00000001 00000000  
cf630000 00000000 00000000 00000000 cf630000 c01e722c c01e722c c012f5e6  
Call Trace: [devfsd_read+852/972] [sys_read+150/204]
[system_call+51/56]  
 
Code: ff 4b 04 0f 94 c0 84 c0 0f 84 9e 00 00 00 3b 1d 00 15 21 c0  

ksymoops 2.4.3 on i686 2.5.1-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre5/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 5a5a5a5e 
c01516f9 
*pde = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0010:[devfs_put+13/188]    Tainted: P  
EFLAGS: 00013206 
eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000016   edx: 5a5a5a5a 
esi: 00000000   edi: 00000026   ebp: 00000000   esp: cf631f40 
ds: 0018   es: 0018   ss: 0018 
Process devfsd (pid: 144, stackpage=cf631000) 
Stack: 00000026 c015419c 5a5a5a5a cf96ba34 ffffffea 00000000 00000420
cfb80800  
c01e7200 cf4f2240 5a5a5a5a 000003fa 00000000 00000000 00000001 00000000  
cf630000 00000000 00000000 00000000 cf630000 c01e722c c01e722c c012f5e6  
Call Trace: [devfsd_read+852/972] [sys_read+150/204]
[system_call+51/56]  
Code: ff 4b 04 0f 94 c0 84 c0 0f 84 9e 00 00 00 3b 1d 00 15 21 c0  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 4b 04                  decl   0x4(%ebx)
Code;  00000002 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   0f 84 9e 00 00 00         je     ac <_EIP+0xac> 000000ac Before
first symbol
Code;  0000000e Before first symbol
   e:   3b 1d 00 15 21 c0         cmp    0xc0211500,%ebx


1 warning issued.  Results may not be reliable.

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
