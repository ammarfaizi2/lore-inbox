Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSAPTqQ>; Wed, 16 Jan 2002 14:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287341AbSAPTqH>; Wed, 16 Jan 2002 14:46:07 -0500
Received: from the-penguin.otak.com ([216.122.56.136]:5504 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S287334AbSAPTqC>; Wed, 16 Jan 2002 14:46:02 -0500
Date: Wed, 16 Jan 2002 11:46:01 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Not feeling the 2.5.2 love
Message-ID: <20020116194601.GA1036@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.5.2 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this oops, might be because there is no swap right now....

Also cmpci.c has not compiled in a while, I can give the errors off list.


ksymoops 2.4.3 on i686 2.5.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.2/ (default)
     -m /System.map (specified)

Jan 16 11:15:55 the-penguin kernel: Unable to handle kernel paging request at virtual address 0a0a3b95
Jan 16 11:15:55 the-penguin kernel: c0136280
Jan 16 11:15:55 the-penguin kernel: *pde = 00000000
Jan 16 11:15:55 the-penguin kernel: Oops: 0000
Jan 16 11:15:55 the-penguin kernel: CPU:    0
Jan 16 11:15:55 the-penguin kernel: EIP:    0010:[hash_page_buffers+80/240]    Not tainted
Jan 16 11:15:55 the-penguin kernel: EFLAGS: 00010203
Jan 16 11:15:55 the-penguin kernel: eax: 00000000   ebx: 0a0a3b7d   ecx: 000001d0   edx: 00000002
Jan 16 11:15:55 the-penguin kernel: esi: 00000000   edi: d0002340   ebp: c11d2740   esp: c1c17f0c
Jan 16 11:15:55 the-penguin kernel: ds: 0018   es: 0018   ss: 0018
Jan 16 11:15:55 the-penguin kernel: Process kswapd (pid: 4, stackpage=c1c17000)
Jan 16 11:15:55 the-penguin kernel: Stack: d0002300 000001d0 d0002340 c01363cc d0002340 000001d0 c11d2740 000001d0 
Jan 16 11:15:55 the-penguin kernel:        0000000f 00002477 c013503c c11d2740 000001d0 d0002340 c11d2740 c012c802 
Jan 16 11:15:55 the-penguin kernel:        c11d2740 000001d0 00000020 000001d0 00000020 00000006 00000006 c1c16000 
Jan 16 11:15:55 the-penguin kernel: Call Trace: [grow_buffers+172/272] [create_buffers+12/224] [shrink_cache+514/704] [try_to_free_pages+22/64] [check_classzone_need_balance+45/48]
Jan 16 11:15:55 the-penguin kernel: Code: f6 43 18 06 0f 84 7f 00 00 00 b8 07 00 00 00 0f ab 43 18 19 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)
Code;  00000004 Before first symbol
   4:   0f 84 7f 00 00 00         je     89 <_EIP+0x89> 00000088 Before first symbol
Code;  0000000a Before first symbol
   a:   b8 07 00 00 00            mov    $0x7,%eax
Code;  0000000e Before first symbol
   f:   0f ab 43 18               bts    %eax,0x18(%ebx)
Code;  00000012 Before first symbol
  13:   19 00                     sbb    %eax,(%eax)



If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.5.2 #5 Tue Jan 15 08:27:09 PST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.25
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         mga ipx hid usbmouse usb-uhci usbcore vfat fat sr_mod cdrom agpgart soundcore 3c59x


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


