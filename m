Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWJBVUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWJBVUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWJBVUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:20:34 -0400
Received: from www.osadl.org ([213.239.205.134]:35011 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965282AbWJBVUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:20:33 -0400
Subject: Re: [patch] dynticks core: Fix idle time accounting
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
	 <1159796582.1386.9.camel@localhost.localdomain>
	 <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
	 <1159814606.1386.52.camel@localhost.localdomain>
	 <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 23:22:38 +0200
Message-Id: <1159824158.1386.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 16:17 -0400, Valdis.Kletnieks@vt.edu wrote:
> cpu  27634 0 7762 20470 881 331 252 0
> cpu0 27634 0 7762 20470 881 331 252 0
> intr 812332 631476 2960 0 4 4 12667 3 14 1 1 4 142891 114 0 22193 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> ctxt 2187603
> btime 1159817297
> processes 4028
> procs_running 1
> procs_blocked 0
> nohz total I:397276 S:379955 T:1187.393123 A:0.003125 E: 629447
> cpu  27753 0 7818 20739 881 332 253 0
> cpu0 27753 0 7818 20739 881 332 253 0
> intr 819027 636542 2969 0 4 4 12801 3 14 1 1 4 144371 114 0 22199 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> ctxt 2209881
> btime 1159817297
> processes 4033
> procs_running 1
> procs_blocked 0
> nohz total I:401991 S:384494 T:1200.732924 A:0.003122 E: 634513

Strange.

/me digs deeper

	tglx


