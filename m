Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSIITdQ>; Mon, 9 Sep 2002 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSIITdQ>; Mon, 9 Sep 2002 15:33:16 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:57275 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S318804AbSIITdP>; Mon, 9 Sep 2002 15:33:15 -0400
Date: Mon, 9 Sep 2002 21:38:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020909212526.28323M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Zwane Mwaikambo wrote:

> > Which is kind of sad. Is there some fast way to read the status of a 
> > level-trigger irq off the IO-APIC in case it is still pending, and to do 
> > the mitigation even for level-triggered?
> 
> perhaps Remote IRR might help there?

 I don't think so.  As far as I understand the I/O APIC operation, you
can't really know the state of an interrupt input when Remote IRR is set
(i.e. an interrupt from the input is being processed).  You can only read
a sort of state of an input from the Delivery Status bit when Remote IRR
is cleared.

 For the i82489DX you could have read the state of an individual interrupt
request from the IRR register of the local unit handling the IRQ. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

