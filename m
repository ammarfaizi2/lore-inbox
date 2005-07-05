Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVGEMgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVGEMgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGEMgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:36:16 -0400
Received: from odin2.bull.net ([192.90.70.84]:58321 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261820AbVGEMae convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:30:34 -0400
Subject: Re: network driver disabled interrupts in PREEMPT_RT
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050621131811.GA23291@elte.hu>
References: <1118688347.5792.12.camel@localhost>
	 <20050613185642.GA12463@elte.hu>
	 <1118839004.17063.19.camel@ibiza.btsn.frna.bull.fr>
	 <20050615130511.GA376@elte.hu>
	 <1118840928.17063.28.camel@ibiza.btsn.frna.bull.fr>
	 <20050621131811.GA23291@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1120565848.6225.15.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 05 Jul 2005 14:17:29 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 21/06/2005 à 15:18, Ingo Molnar a écrit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > > > I have the same problem with an e1000 card for 2.6.12-rc6-RT-V0.7.48-32 :
> > > > #dmesg
> > > > ...
> > > > network driver disabled interrupts: e1000_xmit_frame+0x0/0xbc0 [e1000]
> > > > ...
> > > 
> > > does -48-33 fix it for you?
> > > 
> > > 	Ingo
> 
> > No and I have the tg3_start_xmit too. So the first problem is not 
> > solved. I have the following : network driver disabled interrupts: 
> > tg3_start_xmit+0x0/0x620 [tg3]
> 
> do -50-06 (or later) kernels solve this for you?
> 
> 	Ingo
sorry for the delay. I was out of my office for 2 weeks.
The last RT version I tried was 48-36. it worked.

I'm testing 50-51 wihout succes.
One DEFINE_SPINLOCK is not translated in DEFINE_RAW_SPINLOCK in the
following file :
  CC      arch/i386/kernel/vm86.o
arch/i386/kernel/vm86.c:701: error: syntax error before ',' token
make[4]: *** [arch/i386/kernel/vm86.o] Erreur 1
make[3]: *** [arch/i386/kernel] Erreur 2

is it correct ?
I think I had not this error with 50-47.

