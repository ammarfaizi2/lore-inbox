Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVAMXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVAMXnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVAMXky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:40:54 -0500
Received: from mail.joq.us ([67.65.12.105]:19383 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261810AbVAMXat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:30:49 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	<200501112251.j0BMp9iZ006964@localhost.localdomain>
	<20050111150556.S10567@build.pdx.osdl.net>
	<87y8ezzake.fsf@sulphur.joq.us>
	<20050112074906.GB5735@devserv.devel.redhat.com>
	<87oefuma3c.fsf@sulphur.joq.us>
	<20050113072802.GB13195@devserv.devel.redhat.com>
	<878y6x9h2d.fsf@sulphur.joq.us>
	<20050113210750.GA22208@devserv.devel.redhat.com>
	<1105651508.3457.31.camel@krustophenia.net>
	<20050113214320.GB22208@devserv.devel.redhat.com>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 13 Jan 2005 17:31:40 -0600
In-Reply-To: <20050113214320.GB22208@devserv.devel.redhat.com> (Arjan van de
 Ven's message of "Thu, 13 Jan 2005 22:43:20 +0100")
Message-ID: <87oefs9a8z.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Thu, Jan 13, 2005 at 04:25:08PM -0500, Lee Revell wrote:
>> The basic issue is that the current semantics of SCHED_FIFO seem make
>> the deadlock/data corruption due to runaway RT thread issue difficult.
>> The obvious solution is a new scheduling class equivalent to SCHED_FIFO
>> but with a mechanism for the kernel to demote the offending thread to
>> SCHED_OTHER in an emergency. 
>
> and this is getting really close to the original "counter proposal" to the
> LSM module that was basically "lets make lower nice limit an rlimit, and
> have -20 mean "basically FIFO" *if* the task behaves itself".

Yes.  However, my tests have so far shown a need for "actual FIFO as
long as the task behaves itself."

Otherwise, your rlimits proposal is fine.  I still think it puts more
of a burden on the sysadmin, but nobody else seems to care about that.
-- 
  joq
