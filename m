Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbQLTEIi>; Tue, 19 Dec 2000 23:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbQLTEI3>; Tue, 19 Dec 2000 23:08:29 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:62482 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130895AbQLTEIU>; Tue, 19 Dec 2000 23:08:20 -0500
Date: Tue, 19 Dec 2000 19:37:34 -0800 (PST)
From: ferret@phonewave.net
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <Pine.LNX.3.96.1001219121651.11337A-100000@tarot.mentasm.org>
Message-ID: <Pine.LNX.3.96.1001219193532.13138A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2000 ferret@phonewave.net wrote:
[snip of Petr's system info]

> Okay. Mine, as far as I can tell, only depends on the L2 cache being set
> to '64MB' instead of '512MB' in the field 'L2 Cache Cacheable Size' under
> 'Chipset Features Setup' on my BIOS. This is unfortunately the latest BIOS
> for this motherboard available. It's a TD5TH version 1.1
> 
> Hmmmm. Have you tried booting with an hercmono (if you can get your paws
> on one, that is)?.
> 
> 
> Right after 'Freeing unused kernel memory...'
> I get a kernel BUG at buffer.c:821 with this setting at 256MB, -test12
> without fbcon. With fbcon it would appear to switch video mode and
> freeze with a black screen with cursor at the bottom, at that point.
> 
> And then I get an oops dump in the swapper task. I'll try decoding it in a
> little while, since I'll have to manually input it.

Here we go: I DID have to copy it onto paper and type it in after
rebooting.


>>EIP; c01354a6 <end_buffer_io_async+ea/12c>   <=====
Trace; c0217d72 <tvecs+3a1e/b81c>
Trace; c02180da <tvecs+3d86/b81c>
Trace; c0186e85 <end_that_request_first+65/c0>
Trace; c019e238 <ide_end_request+34/88>
Trace; c01a22b7 <read_intr+e7/120>
Trace; c019fb0e <ide_intr+12a/194>
Trace; c01a21d0 <read_intr+0/120>
Trace; c010c2d1 <handle_IRQ_event+59/84>
Trace; c010c4b8 <do_IRQ+a8/fc>
Trace; c0108d40 <default_idle+0/34>
Trace; c010ac00 <ret_from_intr+0/20>
Trace; c0108d40 <default_idle+0/34>
Trace; c0108dbc <cpu_idle+28/54>
Trace; c0108dd2 <cpu_idle+3e/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001cf <L6+0/2>
Code;  c01354a6 <end_buffer_io_async+ea/12c>
0000000000000000 <_EIP>:
Code;  c01354a6 <end_buffer_io_async+ea/12c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01354a8 <end_buffer_io_async+ec/12c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01354ab <end_buffer_io_async+ef/12c>
   5:   90                        nop
Code;  c01354ac <end_buffer_io_async+f0/12c>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01354b0 <end_buffer_io_async+f4/12c>
   a:   8d 5e 28                  lea    0x28(%esi),%ebx
Code;  c01354b3 <end_buffer_io_async+f7/12c>
   d:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  c01354b6 <end_buffer_io_async+fa/12c>
  10:   39 46 2c                  cmp    %eax,0x2c(%esi)
Code;  c01354b9 <end_buffer_io_async+fd/12c>
  13:   74 00                     je     15 <_EIP+0x15> c01354bb
<end_buffer_io_async+ff/12c>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
