Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272616AbTHKOVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272708AbTHKOTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:19:21 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:60307 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S272705AbTHKORr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:17:47 -0400
Date: Mon, 11 Aug 2003 11:19:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: war <war@lucidpixels.com>
cc: linux-kernel@vger.kernel.org, <kernelnewbies@nl.linux.org>
Subject: Re: Kernel 2.4.21 Crashing
In-Reply-To: <Pine.LNX.4.56.0308102103190.21263@p500>
Message-ID: <Pine.LNX.4.44.0308111119050.27259-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 10 Aug 2003, war wrote:

> I am out of ideas as to what could cause this crashing...
> Can anyone offer any suggestions as to what I should do next?
> 
> war@war:~$ lsmod
> Module                  Size  Used by    Not tainted
> w83781d                20656   0
> i2c-isa                 1160   0 (unused)
> i2c-algo-pcf            5316   0 (unused)
> i2c-algo-bit            7560   0 (unused)
> i2c-dev                 4516   0 (unused)
> i2c-proc                7216   0 [w83781d]
> i2c-core               13028   0 [w83781d i2c-isa i2c-algo-pcf
> i2c-algo-bit i2c-dev i2c-proc]
> emu10k1                66284   0
> ac97_codec             10356   0 [emu10k1]
> sound                  58440   0 (unused)
> war@war:~$
> 
> Other than that, I am not using any binary-only modules or applications.
> 
> My X crashes randomly, my machine panicks, etc...
> 
> I've compiled 2.4.20, 2.4.21, with gcc-3.2.3, gcc-3.3, both have the same
> or similiar problems.
> 
> I am out of ideas, I've tried all sorts of kernels, etc, re-installing
> Slack 9.0, etc, I run the same setup on 2 other machines, and they work
> fine, I've checked all the hardware (memory), (disk (on another machine)),
> etc, it shows as OK.
> 
> Should I try a windows variant (win2k,xp) and see if I get any crashes,
> beucase at this point I am not sure what else to do?
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c0131906
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c0131906>]    Not tainted
> EFLAGS: 00010246
> eax: c0306a18   ebx: 00000000   ecx: c250fffc   edx: 00000000
> esi: c250ffe0   edi: 0001328a   ebp: c0306c40   esp: c2821f40
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 5, stackpage=c2821000)
> Stack: c2095dd0 000001d0 000001ff 000001d0 00000016 0000001f 000001d0 00000020
>        00000006 c0131ca3 00000006 c0306b90 c0306c40 000001d0 00000006 c0306c40
>        00000000 c0131d1e 00000020 c0306c40 00000002 c2820000 c0131e3c c0306c40
> Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0131e3c>] [<c0131eb8>] [<c0131fe8>]
>   [<c0131f50>] [<c0105000>] [<c01057ae>] [<c0131f50>]
> 
> Code: 89 02 c7 01 00 00 00 00 89 50 04 a1 18 6a 30 c0 89 48 04 89
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c0131906
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c0131906>]    Not tainted
> EFLAGS: 00010246
> eax: c0306a18   ebx: 00000000   ecx: c250fffc   edx: 00000000
> esi: c250ffe0   edi: 00013361   ebp: c0306c40   esp: e11c1e04
> ds: 0018   es: 0018   ss: 0018
> Process cp (pid: 8221, stackpage=e11c1000)
> Stack: e11c1e38 c281916c 00000200 000001d2 00000020 00000020 000001d2 00000020
>        00000006 c0131ca3 00000006 004be6f5 c0306c40 000001d2 00000006 c0306c40
>        00000000 c0131d1e 00000020 e11c0000 0000021f c0306c40 c0132ba4 00000000
> Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c012ae99>]
>   [<c012b4ff>] [<c012b77d>] [<c012bcf0>] [<c012be82>] [<c012bcf0>] [<c01834a8>]
>   [<c01399a3>] [<c01073df>]
> 
> Code: 89 02 c7 01 00 00 00 00 89 50 04 a1 18 6a 30 c0 89 48 04 89

Try memtest86 and make sure your memory is OK. After that (in case its not
memory), run the oops output through ksymoops and repost please.

