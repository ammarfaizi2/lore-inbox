Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSD2OrI>; Mon, 29 Apr 2002 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSD2OrI>; Mon, 29 Apr 2002 10:47:08 -0400
Received: from ppp65-120.verat.net ([217.26.65.120]:41856 "EHLO
	spnew.snpe.co.yu") by vger.kernel.org with ESMTP id <S312426AbSD2OrF>;
	Mon, 29 Apr 2002 10:47:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: snpe <snpe@snpe.co.yu>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: ABI & SMP
Date: Mon, 29 Apr 2002 14:58:52 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204271227.06609.snpe@snpe.co.yu> <20020429114312.A3627@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204291458.52342.snpe@snpe.co.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 12:43 pm, Christoph Hellwig wrote:
> On Sat, Apr 27, 2002 at 12:27:06PM +0200, snpe wrote:
> > Hello,
> >    I have kernel 2.4.17 and abi 2.4.17 patch
> > I have used aplication (oracle sqlforms30, runmenu for sco 5, coff).
> > Hardware is Compaq Proliant 1600 with 2 processors.
> > If I use kernel with one processor all is ok, but with SMP kernel
> > I have problem.
> > Application work btw one hour and then I get segmentation fault.
> > I am tried unload moduls and load again without success.
> > After reset all work one hour ...
>
> Do you have any OOPS message or something like that?  Also a trace
> (echo 0xffff > /proc/sys/abi/trace) would be nice to find out the
> last emulated syscall.

This is oops (kernel 2.4.17 + abi-patch 2.4.17) :

Apr 22 08:05:07 jugosped kernel:  <7>[runmenu50:16014]: set personality to 
7000003
Apr 22 08:05:07 jugosped kernel: Unable to handle kernel paging request at 
virtual address e0950000
Apr 22 08:05:07 jugosped kernel:  printing eip:
Apr 22 08:05:07 jugosped kernel: 001853e5
Apr 22 08:05:07 jugosped kernel: *pde = 01938067
Apr 22 08:05:07 jugosped kernel: *pte = 00000000
Apr 22 08:05:07 jugosped kernel: Oops: 0000
Apr 22 08:05:07 jugosped kernel: CPU:    1
Apr 22 08:05:07 jugosped kernel: EIP:    0023:[<001853e5>]    Not tainted
Apr 22 08:05:07 jugosped kernel: EFLAGS: 00010246
Apr 22 08:05:07 jugosped kernel: eax: 00000036   ebx: 00000000   ecx: 00000000   
edx: 00000400
Apr 22 08:05:07 jugosped kernel: esi: 00518648   edi: 005186d8   ebp: bffff3b8   
esp: bffff38c
Apr 22 08:05:07 jugosped kernel: ds: 002b   es: 002b   ss: 002b
Apr 22 08:05:07 jugosped kernel: Process runmenu50 (pid: 16014, 
stackpage=c2135000)
Apr 22 08:05:10 jugosped kernel:  <7>[runmenu50:16018]: set personality to 
7000003
Apr 22 08:05:10 jugosped kernel: Unable to handle kernel paging request at 
virtual address e0950000
Apr 22 08:05:10 jugosped kernel:  printing eip:
Apr 22 08:05:10 jugosped kernel: 00187b35
Apr 22 08:05:10 jugosped kernel: *pde = 01938067
Apr 22 08:05:10 jugosped kernel: *pte = 00000000
Apr 22 08:05:10 jugosped kernel: Oops: 0000
Apr 22 08:05:10 jugosped kernel: CPU:    1
Apr 22 08:05:10 jugosped kernel: EIP:    0023:[<00187b35>]    Not tainted
Apr 22 08:05:10 jugosped kernel: EFLAGS: 00010246
Apr 22 08:05:10 jugosped kernel: eax: 00000032   ebx: 080d028c   ecx: 080d5e0c   
edx: 080ff00c
Apr 22 08:05:10 jugosped kernel: esi: 080d028c   edi: 080d028c   ebp: bffff938   
esp: bffff928
Apr 22 08:05:10 jugosped kernel: ds: 002b   es: 002b   ss: 002b
Apr 22 08:05:10 jugosped kernel: Process runmenu50 (pid: 16018, 
stackpage=c96d7000)

Apr 22 08:09:24 jugosped kernel:  <7>[runform30:16287]: set personality to 
7000003
Apr 22 08:09:24 jugosped kernel: Unable to handle kernel paging request at 
virtual address e0950000
Apr 22 08:09:24 jugosped kernel:  printing eip:
Apr 22 08:09:24 jugosped kernel: 00186e3d
Apr 22 08:09:24 jugosped kernel: *pde = 01938067
Apr 22 08:09:24 jugosped kernel: *pte = 00000000
Apr 22 08:09:24 jugosped kernel: Oops: 0000
Apr 22 08:09:24 jugosped kernel: CPU:    1
Apr 22 08:09:24 jugosped kernel: EIP:    0023:[<00186e3d>]    Not tainted
Apr 22 08:09:24 jugosped kernel: EFLAGS: 00010246
Apr 22 08:09:24 jugosped kernel: eax: 00000032   ebx: 080d0a8c   ecx: 080d0a4c   
edx: 080ff00c
Apr 22 08:09:24 jugosped kernel: esi: 080d0a8c   edi: 080d0a8c   ebp: bffff8a0   
esp: bffff890
Apr 22 08:09:24 jugosped kernel: ds: 002b   es: 002b   ss: 002b
Apr 22 08:09:24 jugosped kernel: Process runform30 (pid: 16287, 
stackpage=db38d000)

I don't make trace now, because machine is production and I compile UP kernel
In next few days, I get obtain 2-processor machine (Dell, probably) and tried 
trace

regards
haris peco
snpe@snpe.co.yu 
