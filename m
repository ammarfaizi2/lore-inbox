Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUECNmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUECNmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUECNmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:42:35 -0400
Received: from linuxhacker.ru ([217.76.32.60]:19135 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263713AbUECNmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:42:33 -0400
Date: Mon, 3 May 2004 16:42:35 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Stromsoe <cbs@cts.ucla.edu>, linux-kernel@vger.kernel.org
Subject: Re: two lockups with 2.4.25
Message-ID: <20040503134235.GC1794@linuxhacker.ru>
References: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu> <200404211510.i3LFAGe7031761@car.linuxhacker.ru> <Pine.LNX.4.58.0404210814370.10269@potato.cts.ucla.edu> <20040503125108.GA29160@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503125108.GA29160@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, May 03, 2004 at 09:51:08AM -0300, Marcelo Tosatti wrote:
> > > Chris Stromsoe <cbs@cts.ucla.edu> wrote:
> > > CS> Pid: 26885, comm:               sophie
> > > >>>EIP; c0110ed7 <flush_tlb_others+9b/bc>   <=====
> > > >>>EDX; 01000000 Before first symbol
> > > >>>ESI; f4762cc0 <_end+343c85cc/3896e90c>
> > > >>>EDI; 081a1d28 Before first symbol
> > > >>>EBP; e806fe94 <_end+27cd57a0/3896e90c>
> > > CS> Trace; c011100f <flush_tlb_page+6f/7c>
> > > CS> Trace; c01259b7 <do_wp_page+223/284>
> > > CS> Trace; c01260de <handle_mm_fault+82/b8>
> > > CS> Trace; c01132f9 <do_page_fault+1a1/4ed>
> > > CS> Trace; c0113158 <do_page_fault+0/4ed>
> > > CS> Trace; c0224ce1 <__kfree_skb+129/134>
> > > CS> Trace; c01145e3 <schedule+45b/520>
> > > CS> Trace; c0106fc4 <error_code+34/3c>
> > > This backtrace is suspiciously similar to a backtrace from NMI WD I had
> > > not so long ago. Also on 2.5.25 Are your boxes SMP?
> AFAICS this backtrace is fine -- flush_tlb_others() does invplg and thats it. No
> locking involved, yes?

Well, the trace looks fine, except the box was hung at the time of the
trace capturing. And most of the trace is the same as I had reported with
NMI watchdog. This is the only thing I was going to say.
So far the box I experienced NMI WD oops on works and does not hang.
And I posted previous oops on lkml.
If something will happen to it again, I won't keep it secret for sure ;)

Bye,
    Oleg
