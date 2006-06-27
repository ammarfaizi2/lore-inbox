Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWF0TKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWF0TKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWF0TKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:10:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5806 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932254AbWF0TKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:10:14 -0400
Date: Tue, 27 Jun 2006 21:09:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
In-Reply-To: <1151421452.32186.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0606272104500.7853@yvahk01.tjqt.qr>
References: <20060626151012.GR23314@stusta.de>  <20060626153834.GA18599@redhat.com>
  <1151336815.3185.61.camel@laptopd505.fenrus.org>  <20060626155439.GB18599@redhat.com>
  <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
 <1151421452.32186.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > cli/sti should just be removed, or at least have those drivers marked
>> > > BROKEN... nobody is apparently using them anyway...
>> >
>> >Just ISDN really.
>> >
>> And ISDN is widespread in Germany (besides 56k and DSL(PPPOE)).
>
>Then there should be lots of Germans eager to fix it when it gets dealt
>with.
>

/* Heh, heh */

So what do I need to replace cli/sti with?

Oh btw:
(linux-2.6.17)
21:05 shanghai:../drivers/isdn > grep cli'()'  -lr .
./hardware/avm/t1isa.c
./hysdn/boardergo.c
./hysdn/hysdn_proclog.c
./hysdn/hysdn_sched.c
./isdnloop/isdnloop.c

There does not really seem to be a lot of places (yes, isdnloop is full of 
it) to change. Especially HISAX has no cli/stis anymore as it seems, 
which, among AVM stuff, is commonly in use. I am running this one:
  00:0a.0 Network controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN 
  interface (PCI, CONFIG_HISAX_NETJET)
previously I had a Teledat 100 (ISA, CONFIG_HISAX_SEDLBAUER) but had to 
replace that when I got a new motherboard with no ISA slots.


Have a nice day,
Jan Engelhardt
-- 
