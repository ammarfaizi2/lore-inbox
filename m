Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFAVam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFAVam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:30:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15524 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261186AbVFAV3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:29:51 -0400
Date: Wed, 01 Jun 2005 17:29:48 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: RT patch acceptance
In-reply-to: <20050601210716.GB5413@g5.random>
X-X-Sender: nico@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.63.0506011724310.17354@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050601192224.GV5413@g5.random>
 <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk>
 <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com>
 <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com>
 <20050601210716.GB5413@g5.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> Why don't you run grep yourself, this is only drivers/
> 
[...]
> ./mtd/chips/cfi_cmdset_0001.c:	local_irq_disable();
> ./mtd/chips/cfi_cmdset_0001.c:			local_irq_disable();

I can speak at least for those two since I added them and they are 
indeed OK with RT and actually needed even with RT.

> As said even if all the above is audited, it _can_ break over time,
> while it wouldn't break with RTAI/rtlinux even if you infinite loop and
> hang in there.

Actualy it's RTAI/rtlinux which is broken wrt the above IRQ disable.
See for yourself when they're used and watch RTAI/rtlinux crash.  


Nicolas
