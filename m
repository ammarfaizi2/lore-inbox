Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSCOQMb>; Fri, 15 Mar 2002 11:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292852AbSCOQMV>; Fri, 15 Mar 2002 11:12:21 -0500
Received: from kim.it.uu.se ([130.238.12.178]:46833 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S292857AbSCOQMI>;
	Fri, 15 Mar 2002 11:12:08 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15506.7486.729120.64389@kim.it.uu.se>
Date: Fri, 15 Mar 2002 17:11:42 +0100
To: Robert Love <rml@tech9.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
In-Reply-To: <1016202310.908.1.camel@phantasy>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
	<1016157250.4599.62.camel@phantasy>
	<3C91B2A1.48C74B82@ianduggan.net>
	<1016202310.908.1.camel@phantasy>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
 > Chances are the binary win4lin module just needs to be recompiled
 > against a preemptive kernel.
 > 
 > Of course, it could need some specific preempt-safe work but more than
 > likely it just needs to be recompiled.  Binary modules most be
 > specifically preempt-kernel aware, like they need be SMP-kernel aware.

"more than likely": that's perhaps true for your average NIC/soundcard/
whatever driver, but things that poke the processor itself (like my
performance-monitoring counters driver) really do depend on not being
preempted. In my view, CONFIG_SMP is a minor triviality compared to
CONFIG_PREEMPT ...

/Mikael
