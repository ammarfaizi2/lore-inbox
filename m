Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbULSQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbULSQWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbULSQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:22:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43144
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261306AbULSQWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:22:13 -0500
Subject: Re: Linux 2.6.9-ac16
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Davidsen <davidsen@tmr.com>
Cc: Chris Ross <chris@tebibyte.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <41C448BB.1020902@tmr.com>
References: <41C2FF09.5020005@tebibyte.org>
	 <1103222616.21920.12.camel@localhost.localdomain>
	 <1103349675.27708.39.camel@tglx.tec.linutronix.de>
	 <41C448BB.1020902@tmr.com>
Content-Type: text/plain
Date: Sun, 19 Dec 2004 17:22:11 +0100
Message-Id: <1103473331.27708.50.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-18 at 10:11 -0500, Bill Davidsen wrote:

> As someone who runs most new versions first on a 96MB (slow) machine, I 
> would agree that this is a desirable change. I'm not sure yet if the 
> selection is optimal, but it's better than the stock kernel, which seems 
> to follow the "kill them all, let god sort it out" principle.

The main fix IMHO is Andrea's correct solution of the invocation
including the removal of the evidential useless protection timers and
counters in out_of_memory().

The selection mechanism is now nearly matching the comment above badness
() much better: "this algorithm has been meticulously tuned to meet the
principle of least surprise ... (be careful when you change it)".

It can always be further optimized, but it will never meet the
expectation of all users

tglx


