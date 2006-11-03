Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753231AbWKCLaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbWKCLaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbWKCLaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:30:19 -0500
Received: from mout2.freenet.de ([194.97.50.155]:23248 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1753231AbWKCLaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:30:18 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
Date: Fri, 3 Nov 2006 12:30:24 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
In-Reply-To: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031230.24983.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 2. November 2006 11:43 schrieb Rui Nuno Capela:
> 
> While on UP kernels everything works great and without major issues to
> report, problem goes here on the SMP/HT one. Simple fact: it hangs,
> freezes in some non-deterministic ways. However, sometimes, it is just a
> matter of a couple of dozen clicks while browsing over those
> funky-ajax-enabled-web2 sites :)
> 
> ........
> 
> Call Trace:
>  [<c011e631>] __activate_task+0x21/0x40
>  [<c01209b1>] try_to_wake_up+0x321/0x450
>  [<c0144822>] wakeup_next_waiter+0xd2/0x1d0
>  [<c0120b59>] wake_up_process_mutex+0x19/0x20
>  [<c0300531>] rt_spin_lock_slowunlock+0x41/0x70
>  [<c02ff34c>] __schedule+0xc0c/0xee0
>  [<c014091a>] hrtimer_interrupt+0x18a/0x250

Does it make a difference, if you build & run with
CONFIG_HIGH_RES_TIMERS disabled?

      Karsten
