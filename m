Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVBDAgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVBDAgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVBDAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:36:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:61415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262026AbVBDAfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:35:55 -0500
Date: Thu, 3 Feb 2005 16:35:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203163520.D24171@build.pdx.osdl.net>
References: <42014C10.60407@bigpond.net.au> <200502022303.j12N3nZa002055@localhost.localdomain> <20050203213645.GB27255@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050203213645.GB27255@elte.hu>; from mingo@elte.hu on Thu, Feb 03, 2005 at 10:36:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> i believe RT-LSM provides a way to solve this cleanly: you can make your
> audio app setguid-audio (note: NOT setuid), and make the audio group
> have CAP_SYS_NICE-equivalent privilege via the RT-LSM, and then you
> could have a finegrained per-app way of enabling SCHED_FIFO scheduling,
> without giving _users_ the blanket permission to SCHED_FIFO. Ok?
> 
> this way if jackd (or a client) gets run by _any_ user, all jackd
> processes will be part of the audio group and can do SCHED_FIFO - but
> users are not automatically trusted with SCHED_FIFO.
> 
> you are currently using RT-LSM to enable a user to do SCHED_FIFO, right? 
> I think the above mechanism is more secure and more finegrained than
> that.

No, rt-lsm is actually gid based.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
