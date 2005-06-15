Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFONVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFONVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 09:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVFONVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 09:21:30 -0400
Received: from odin2.bull.net ([192.90.70.84]:5796 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261382AbVFONV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 09:21:26 -0400
Subject: Re: network driver disabled interrupts in PREEMPT_RT
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050615130511.GA376@elte.hu>
References: <1118688347.5792.12.camel@localhost>
	 <20050613185642.GA12463@elte.hu>
	 <1118839004.17063.19.camel@ibiza.btsn.frna.bull.fr>
	 <20050615130511.GA376@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1118840928.17063.28.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 15 Jun 2005 15:08:49 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 15/06/2005 à 15:05, Ingo Molnar a écrit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > Le lun 13/06/2005 à 20:56, Ingo Molnar a écrit :
> > > * Kristian Benoit <kbenoit@opersys.com> wrote:
> > > 
> > > > Hi,
> > > > I got lots of these messages when accessing the net running
> > > > 2.6.12-rc6-RT-V0.7.48-25 :
> > > > 
> > > > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> > > > 
> > > > it seem to come from net/sched/sch_generic.c.
> > > 
> > > does the patch below fix it?
> > > 
> > > 	Ingo
> > I have the same problem with an e1000 card for 2.6.12-rc6-RT-V0.7.48-32 :
> > #dmesg
> > ...
> > network driver disabled interrupts: e1000_xmit_frame+0x0/0xbc0 [e1000]
> > ...
> 
> does -48-33 fix it for you?
> 
> 	Ingo
No and I have the tg3_start_xmit too. So the first problem is not solved.
I have the following :
network driver disabled interrupts: tg3_start_xmit+0x0/0x620 [tg3]

