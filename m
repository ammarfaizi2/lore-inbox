Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSKGQ03>; Thu, 7 Nov 2002 11:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSKGQ03>; Thu, 7 Nov 2002 11:26:29 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:38577 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261426AbSKGQ02>; Thu, 7 Nov 2002 11:26:28 -0500
Date: Thu, 7 Nov 2002 17:30:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bill Davidsen <davidsen@tmr.com>
cc: John Levon <levon@movementarian.org>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
In-Reply-To: <Pine.LNX.3.96.1021107111731.30525A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.GSO.3.96.1021107172624.5894G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Bill Davidsen wrote:

> By any chance, does this implementation imply that if I boot SMP with
> 'noapic' the NMI watchdog won't work? It doesn't, but I am not sure I had
> it on before I turned off the APIC.

 The I/O APIC watchdog won't be enabled as the chip isn't used then.  You
may still use the local APIC watchdog (i.e. "nmi_watchdog=2"), but that
requires at least a P6-class processor (while the I/O APIC watchdog works
even with the i486). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

