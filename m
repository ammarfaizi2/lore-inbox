Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDODsm>; Sat, 14 Apr 2001 23:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDODsc>; Sat, 14 Apr 2001 23:48:32 -0400
Received: from stanis.onastick.net ([207.96.1.49]:21003 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132570AbRDODsY>; Sat, 14 Apr 2001 23:48:24 -0400
Date: Sat, 14 Apr 2001 23:48:10 -0400
From: Disconnect <dis@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with k7 optimizations in 2.4.x?
Message-ID: <20010414234810.A13205@sigkill.net>
In-Reply-To: <20010413113952.F21462@sigkill.net> <E14o69g-00037Z-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14o69g-00037Z-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Blew sky high. Booted stock 2.4.3-ac3, K7 optimizations, init=/bin/sh.  
First time it went fine for quite some time (10-15 mins, find / -print,
etc) and then locked up hard on "open".  Second time, it oops'd before
hardlocking (which I copied out by hand.) The oops and decode are
attached.

On Fri, 13 Apr 2001, Alan Cox did have cause to say:

> > On the iwill mobo? (I haven't heard of this problem on other
> > motherboards.)
> 
> Im not using an Iwill board. I'm using an AMD751/756 based board and an old
> 'Uncle Fester' reference board.
> 
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="decode.txt"

ksymoops 2.3.7 on i686 2.4.3.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)
     -1

EIP: c023873a
Call Trace: [<c0238847>] [<c0121295>] [<c0121a3b>] [<c0110d18>] [<c0110bc0>] [<c011be74>] [<c011ce4a>] [<c011d1f5>] [<c010714c>]
Code: 0f 6f 03 0f e7 06 0f 6f 4b 08 0f e7 4e 08 0f 6f 53 10 0f e7
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c0238847 <mmx_copy_page+37/40>
Trace; c0121295 <do_wp_page+1c5/230>
Trace; c0121a3b <handle_mm_fault+9b/d0>
Trace; c0110d18 <do_page_fault+158/440>
Trace; c0110bc0 <do_page_fault+0/440>
Trace; c011be74 <rm_sig_from_queue+14/20>
Trace; c011ce4a <do_sigaction+ba/120>
Trace; c011d1f5 <sys_rt_sigaction+75/d0>
Trace; c010714c <error_code+34/3c>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 6f 03                  movq   (%ebx),%mm0
Code;  00000003 Before first symbol
   3:   0f e7 06                  movntq %mm0,(%esi)
Code;  00000006 Before first symbol
   6:   0f 6f 4b 08               movq   0x8(%ebx),%mm1
Code;  0000000a Before first symbol
   a:   0f e7 4e 08               movntq %mm1,0x8(%esi)
Code;  0000000e Before first symbol
   e:   0f 6f 53 10               movq   0x10(%ebx),%mm2
Code;  00000012 Before first symbol
  12:   0f e7 00                  movntq %mm0,(%eax)


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

null pointer defref 00000000
EIP: c023873a
pgd entry d9040000 - 00000000
pmd entry d9040000 - 00000000
pmd not present!

Call Trace: [<c0238847>] [<c0121295>] [<c0121a3b>] [<c0110d18>] [<c0110bc0>] [<c011be74>] [<c011ce4a>] [<c011d1f5>] [<c010714c>]
Code: 0f 6f 03 0f e7 06 0f 6f 4b 08 0f e7 4e 08 0f 6f 53 10 0f e7

--/04w6evG8XlLl3ft--
