Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUECMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUECMtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUECMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:49:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263100AbUECMti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:49:38 -0400
Date: Mon, 3 May 2004 09:51:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
Subject: Re: two lockups with 2.4.25
Message-ID: <20040503125108.GA29160@logos.cnet>
References: <Pine.LNX.4.58.0404201554590.4433@potato.cts.ucla.edu> <200404211510.i3LFAGe7031761@car.linuxhacker.ru> <Pine.LNX.4.58.0404210814370.10269@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404210814370.10269@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:19:20AM -0700, Chris Stromsoe wrote:
> On Wed, 21 Apr 2004, Oleg Drokin wrote:
> 
> > Chris Stromsoe <cbs@cts.ucla.edu> wrote:
> > CS> Pid: 26885, comm:               sophie
> > >>>EIP; c0110ed7 <flush_tlb_others+9b/bc>   <=====
> > >>>EDX; 01000000 Before first symbol
> > >>>ESI; f4762cc0 <_end+343c85cc/3896e90c>
> > >>>EDI; 081a1d28 Before first symbol
> > >>>EBP; e806fe94 <_end+27cd57a0/3896e90c>
> > CS> Trace; c011100f <flush_tlb_page+6f/7c>
> > CS> Trace; c01259b7 <do_wp_page+223/284>
> > CS> Trace; c01260de <handle_mm_fault+82/b8>
> > CS> Trace; c01132f9 <do_page_fault+1a1/4ed>
> > CS> Trace; c0113158 <do_page_fault+0/4ed>
> > CS> Trace; c0224ce1 <__kfree_skb+129/134>
> > CS> Trace; c01145e3 <schedule+45b/520>
> > CS> Trace; c0106fc4 <error_code+34/3c>
> >
> > This backtrace is suspiciously similar to a backtrace from NMI WD I had
> > not so long ago. Also on 2.5.25 Are your boxes SMP?
> 
> The boxes are SMP (dual cpu p3 1400MHz).

Oleg,

AFAICS this backtrace is fine -- flush_tlb_others() does invplg and thats it. No
locking involved, yes?

I can see very interesting JFS traces in Chris's report. I'll answer his message.
