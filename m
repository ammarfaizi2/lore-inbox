Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933385AbWLFPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWLFPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933336AbWLFPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:09:25 -0500
Received: from twin.jikos.cz ([213.151.79.26]:57339 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933385AbWLFPJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:09:24 -0500
Date: Wed, 6 Dec 2006 16:08:39 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Jaswinder Singh <jaswinderrajput@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Andrew Morton <akpm@osdl.org>, Jiri Kosina <jkosina@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
In-Reply-To: <aa5953d60612060635l43b79ed8g1196cfc0435c0cb1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612061603170.28502@twin.jikos.cz>
References: <20061205172737.14ecfeb3.akpm@osdl.org> 
 <200612061252.kB6CqRYP008046@laptop13.inf.utfsm.cl>  <20061206135445.GA17224@elte.hu>
 <aa5953d60612060635l43b79ed8g1196cfc0435c0cb1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Jaswinder Singh wrote:

> I am playing with linux kernel but kernel dumps on WARN_ON , when I 
> commented WARN_ON in my code my kernel starts working but I get two 
> sideeffects :-

Hi,

please, submit a proper bugreport, including all the needed data (see 
REPORTING-BUGS document in the kernel sources), namely kernel version, HW 
architecture, extra patches applied, configuration, loaded modules, etc.

Also, your issue is not related to this thread at all, could you please 
start a new one with more descriptive name, so there is a chance that 
someone responsible notices? This thread is about how WARN_ON is 
implemented, not about problems with certain modules triggering WARN_ON 
messages.

> Internal error: Oops: 17 [#1]
> Modules linked in:Modules linked in:
> CPU: 0
> CPU: 0
> PC is at dequeue_task+0xc/0x78
> PC is at dequeue_task+0xc/0x78
> LR is at deactivate_task+0x24/0x30
> LR is at deactivate_task+0x24/0x30
> pc : [<c0037264>]    lr : [<c003759c>]    Not tainted
> sp : c545ddcc  ip : c545dddc  fp : c545ddd8
> pc : [<c0037264>]    lr : [<c003759c>]    Not tainted
> sp : c545ddcc  ip : c545dddc  fp : c545ddd8
> r10: c68fd340  r9 : c02e04d4  r8 : c028ccf8
> r10: c68fd340  r9 : c02e04d4  r8 : c028ccf8
> r7 : c028ded8  r6 : c028ccf4  r5 : c545c000  r4 : c68fd340
> r7 : c028ded8  r6 : c028ccf4  r5 : c545c000  r4 : c68fd340
> r3 : 00000002  r2 : 00000000  r1 : 00000000  r0 : c68fd340
> r3 : 00000002  r2 : 00000000  r1 : 00000000  r0 : c68fd340
> Flags: NzcvFlags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment user
>  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: 5317F  Table: 85810000  DAC: 00000015
> Control: 5317F  Table: 85810000  DAC: 00000015
> Process X (pid: 1107, stack limit = 0xc545c198)
> Process X (pid: 1107, stack limit = 0xc545c198)
> Stack: (0xc545ddcc to 0xc545e000)
> Stack: (0xc545ddcc to 0xc545e000)

BTW seems really strange. Do you really get all the lines output twice?

Thanks,

-- 
Jiri Kosina
