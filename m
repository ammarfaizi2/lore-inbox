Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265803AbUFXWAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUFXWAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUFXV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:59:43 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:17624 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265817AbUFXV7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:59:05 -0400
Date: Thu, 24 Jun 2004 17:58:57 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624215856.GA728@washoe.rutgers.edu>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624212600.GW728@washoe.rutgers.edu>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just once again and I will stop before I try with noioapic and acpi=off:

when I did strace on ps auxw it spends second or two again on mmap2
whenever it doesn't do that on any other machine

here is strace with relative timestamps (strace -r) of ps auxw

3003       0.001784 open("/boot/System.map-2.6.7-bk7", O_RDONLY|O_NONBLOCK|O_NOCTTY) = 6
3003       0.001171 fstat64(6, {st_mode=S_IFREG|0644, st_size=932887, ...}) = 0
3003       0.001598 mmap2(NULL, 932888, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x40163000
3003       0.001156 close(6)            = 0
3003       1.930769 mmap2(NULL, 266240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40247000
3003       1.322821 open("/proc", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 6
3003       0.001124 fstat64(6, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0

On Thu, Jun 24, 2004 at 05:26:00PM -0400, Yaroslav Halchenko wrote:
> On Thu, Jun 24, 2004 at 11:58:55PM +0300, Denis Vlasenko wrote:
> > Do a

> > # strace -p 1501

> > and you'll se what's going on

> can you please help me to understand the dump?

> time strace -p 2586
> Process 2586 attached - interrupt to quit
> brk(0)                                  = 0x8dff000
> brk(0x8e21000)                          = 0x8e21000
> brk(0)                                  = 0x8e21000
> brk(0x8e43000)                          = 0x8e43000
> brk(0)                                  = 0x8e43000
> brk(0x8e65000)                          = 0x8e65000
> brk(0)                                  = 0x8e65000
> brk(0x8e87000)                          = 0x8e87000
> brk(0)                                  = 0x8e87000
> brk(0x8ea9000)                          = 0x8ea9000
> brk(0)                                  = 0x8ea9000
> brk(0x8ecb000)                          = 0x8ecb000
> brk(0)                                  = 0x8ecb000
> brk(0x8eed000)                          = 0x8eed000
> brk(0)                                  = 0x8eed000
> brk(0x8f0f000)                          = 0x8f0f000
> brk(0)                                  = 0x8f0f000
> brk(0x8f30000)                          = 0x8f30000
> brk(0)                                  = 0x8f30000
> brk(0x8f52000)                          = 0x8f52000
> Process 2586 detached

> real    0m6.927s
> user    0m0.032s
> sys     0m0.004s

> if I dump longer than the rest kinda flies so it is slows down just
> after
> open("/var/lib/dpkg/available", O_RDONLY) = 4
> fstat64(4, {st_mode=S_IFREG|0644, st_size=12398100, ...}) = 0
> mmap2(NULL, 12398100, PROT_READ, MAP_SHARED, 4, 0) = 0x40157000
> brk(0)                                  = 0x840e000
> brk(0x8430000)                          = 0x8430000
> brk(0)                                  = 0x8430000
> ....

> I will check once more when it 'delays'
-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

