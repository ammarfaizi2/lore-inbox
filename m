Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJSHjB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 03:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTJSHjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 03:39:01 -0400
Received: from adsl-215-226.38-151.net24.it ([151.38.226.215]:64018 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262015AbTJSHi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 03:38:59 -0400
Date: Sun, 19 Oct 2003 09:38:45 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ollie Lho <ollie@sis.com.tw>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031019073845.GA820@picchio.gall.it>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ollie Lho <ollie@sis.com.tw>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li> <20031015210054.GA1492@picchio.gall.it> <20031016140644.GJ1659@openzaurus.ucw.cz> <20031018175423.GA1038@renditai.milesteg.arr> <20031018180102.GA461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018180102.GA461@elf.ucw.cz>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ed sis900 mantainer.

On Sat, Oct 18, 2003 at 08:01:02PM +0200, Pavel Machek wrote:
> Did sis900 driver work in -test7?

No, it didn't and reconfiguring the interface after resume doesn't 
make it work, probably it needs a module reload, but I use sis900
compiled in.

For the bash problem, there is something different between test7 and test8, 
with test7 I get on resume:

Unable to handle kernel paging request at virtual address 401289b8
 printing eip:
401289b8
*pde = 0155d067
*pte = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<401289b8>]    Not tainted
EFLAGS: 00010246
EIP is at 0x401289b8
eax: 00000004   ebx: 00000001   ecx: 080f8c08   edx: 00000004
esi: 00000004   edi: 080f8c08   ebp: bffff868   esp: bffff838
ds: 007b   es: 007b   ss: 007b
Process bash (pid: 1037, threadinfo=dafec000 task=db29a140)
 <6>note: bash[1037] exited with preempt_count 1

And then bash dies. With test8, bash dies the same, but there is no such
message on resume...

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

