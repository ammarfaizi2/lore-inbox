Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264842AbUD2PLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbUD2PLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUD2PLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:11:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5303 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264842AbUD2PLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:11:07 -0400
Date: Thu, 29 Apr 2004 12:12:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Albert Chin-A-Young <china@thewrittenword.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at inode.c:1204! in 2.2.26
Message-ID: <20040429151216.GB19181@logos.cnet>
References: <20040429041420.GA85751@mail1.thewrittenword.com> <20040429143351.GA19056@logos.cnet> <20040429144623.GA52886@mail1.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429144623.GA52886@mail1.thewrittenword.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:46:23AM -0500, Albert Chin-A-Young wrote:
> On Thu, Apr 29, 2004 at 11:33:51AM -0300, Marcelo Tosatti wrote:
> > 
> > I believe this mibht be caused by the VMWare modules you are using.
> > 
> > Mind trying to reproduce it without external modules?
> 
> Sure. I'll reboot tonight without the modules. BTW, why do you think
> this?

Because I've never seen such report on mainline.

But actually this might be related to some fixes in the VFS. 

In the meantine, run without the vmware modules please.

> > On Wed, Apr 28, 2004 at 11:14:20PM -0500, Albert Chin-A-Young wrote:
> > > Upgraded to 2.2.26 on April 26 and received the following on April 27:
> > > 
> > > kernel: kernel BUG at inode.c:1204!
> > > kernel: invalid operand: 0000
> > > kernel: CPU:    0
> > > kernel: EIP:    0010:[iput+608/624] Tainted: PF
> > > kernel: EFLAGS: 00010246
> > > kernel: eax: 00000000   ebx: de603980   ecx: de603990   edx: de603990
> > > kernel: esi: f7e6bc00   edi: 00000000   ebp: 00007a61   esp: f7e71efc
> > > kernel: ds: 0018   es: 0018   ss: 0018
> > > kernel: Process kswapd (pid: 4, stackpage=f7e71000)
> > > kernel: Stack: 00000292 de605880 00000292 de605918 de605900 de603980 c0148a4d de603980 
> > > kernel:        de605880 00000017 c1886114 c0260e38 000063ad c0148da4 00009446 c012d336 
> > > kernel:        00000006 000001d0 ffffffff 000001d0 00000017 00000020 000001d0 c0260e38 
> > > kernel: Call Trace:    [prune_dcache+221/336] [shrink_dcache_memory+36/64] [shrink_cache+358/896] [shrink_caches+61/96] [try_to_free_pages_zone+98/240]
> > > kernel:   [kswapd_balance_pgdat+102/176] [kswapd_balance+40/64] [kswapd+152/192] [kswapd+0/192] [rest_init+0/64] [arch_kernel_thread+46/64]
> > > kernel:   [kswapd+0/192]
> > > kernel: 
> > > kernel: Code: 0f 0b b4 04 86 4b 23 c0 e9 c3 fd ff ff 8d 76 00 8b 54 24 04 
> > > 
> > > I did not encounter an OOPS. I saw this and then rebooted.
