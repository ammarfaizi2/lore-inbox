Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161697AbWKEUSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161697AbWKEUSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161698AbWKEUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:18:48 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31752 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161697AbWKEUSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:18:47 -0500
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
From: Daniel Walker <dwalker@mvista.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Karsten Wiese <fzu@wemgehoertderstaat.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <454E2FC1.4040700@rncbc.org>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
	 <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org>
		 <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>
		 <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org>
	 <1162742535.2750.23.camel@localhost.localdomain>
	 <454E2FC1.4040700@rncbc.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 13:18:45 -0500
Message-Id: <1162750725.2750.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try turning this option in Kernel Hacking
"RT Mutex debugging, deadlock detection"

I'm assuming it's off.

On Sun, 2006-11-05 at 18:38 +0000, Rui Nuno Capela wrote:
> Daniel Walker wrote:
> > On Sun, 2006-11-05 at 16:47 +0000, Rui Nuno Capela wrote:
> >> Rui Nuno Capela wrote:
> >>> After a suggestion from Mike Galbraith, I now turned to pure and
> >>> original 2.6.18-rt7 and configured with:
> >>>
> >>> CONFIG_FRAME_POINTER=y
> >>> CONFIG_UNWIND_INFO=y
> >>> CONFIG_STACK_UNWIND=y
> >>>
> >>> Nasty things still do happen, as the following capture can tell as evidence:
> >>>
> >> Some more evidence, just happening:
> >>
> >> ...
> >> Oops: 0002 [#1]
> >>  [<c0106455>] show_trace_log_lvl+0x185/0x1a0
> >>  [<c0106ae2>] show_trace+0x12/0x20
> >>  [<c0106c49>] dump_stack+0x19/0x20
> >>  [<c02f8d2f>] __schedule+0x63f/0xea0
> >>  [<c02f9700>] schedule+0x30/0x100
> >>  [<c02fa5db>] rt_spin_lock_slowlock+0x9b/0x1b0
> >>  [<c02fadb2>] rt_spin_lock+0x22/0x30
> >>  [<c02fd8b1>] kprobe_flush_task+0x11/0x50
> >>  [<c02f91fa>] __schedule+0xb0a/0xea0
> >>  [<c0103b61>] cpu_idle+0xb1/0x120
> >>  [<c011760f>] start_secondary+0x43f/0x500
> > 
> > Is there more above this log? It looks like your cutting off some stuff
> > above this.
> > 
> > Daniel
> 
> Yes there is. However I didn't find it relevant. Here it goes now (full
> captured serial-console log):
> 
> --

