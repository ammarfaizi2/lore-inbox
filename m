Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSIFI0t>; Fri, 6 Sep 2002 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSIFI0s>; Fri, 6 Sep 2002 04:26:48 -0400
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:14375
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S317398AbSIFI0s>; Fri, 6 Sep 2002 04:26:48 -0400
Date: Fri, 6 Sep 2002 10:32:54 +0200
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Little bug in O(1) scheduler patch (also in 2.4.19-ac4)
Message-ID: <20020906083254.GA769@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 a module compiled for kernel 2.4.19-ac4, with CONFIG_MODVERSIONS, and
importing flush_signals() from kernel, fails to load, reporting
"unresolved symbol flush_signals_xxxxxxxx".

 The problem is that the type of the argument passed to flush_signals()
has been changed from "struct task_struct *" to "task_t *" in sched.h,
but it remains unchanged in kernel/signal.c. The same happens with
flush_signal_handlers().

 Sorry if this is a known issue.

Regargs,
Juanma

PS: First sent to Ingo Molnar, since no response, reposting here again.

-- 
/jm

