Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUCVTYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUCVTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:24:18 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:15620 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S262279AbUCVTYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:24:16 -0500
Subject: Re: 2.6.5-rc2-mm1 does not boot. 2.6.5-rc1-mm2 + small fix from
	axboe was fine
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Eric Valette <eric.valette@free.fr>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403220048160.28727@montezuma.fsmlabs.com>
References: <405DFA02.8090504@free.fr>
	 <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com>
	 <405E1993.4050907@free.fr>
	 <Pine.LNX.4.58.0403220048160.28727@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1079983253.28657.4.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Mar 2004 16:20:53 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zwane,

Em Seg, 2004-03-22 às 02:49, Zwane Mwaikambo escreveu:
> On Sun, 21 Mar 2004, Eric Valette wrote:
> 
> > > How about the following patch?
> >
> > OK this time, I used the correct original file, applied your patch. But
> > it does not help. This time it freeze immediately after :
> > Freeing unused kernel memory: 216k freed.
> >
> > Thanks anyway for the suggestion and sorry for the mistake on using the
> > wrong version of init/main.c (after partially reverse applying the
> > possible incorrect patch).
> 
> The patch actually fixed a bug i thought you were hitting;
> 
> Freeing 1nunedlketo lamdlo y:r3elkpfgeeg
> equest at virtual address c06c22a0
>  printing eip:
> c06c22a0
> *pde = 00757027
> Oops: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> CPU:    1
> EIP:    0060:[<c06c22a0>]    Not tainted VLI
> EFLAGS: 00010213   (2.6.5-rc2-mm1)
> EIP is at prepare_namespace+0x0/0xd0
> eax: 00000002   ebx: 00000000   ecx: c060b2c0   edx: c060b300
> esi: 00000001   edi: 00000000   ebp: dff8ffec   esp: dff8ffd4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=dff8f000 task=dff1fa50)
> Stack: c0103235 00000000 00000000 0000007b c0103170 00000000 00000000 c01051f5
>        00000000 00000000 00000000
> Call Trace:
>  [<c0103235>] init+0xc5/0x190
>  [<c0103170>] init+0x0/0x190
>  [<c01051f5>] kernel_thread_helper+0x5/0x10
> 
> Code:  Bad EIP value.
>  <0>Kernel panic: Attempted to kill init!

 I got it, your patch does not fix it, but removing the
initramfs-search-for-init.patch fixed the problem.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

