Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVAMVvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVAMVvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVAMVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:50:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261719AbVAMVoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:44:38 -0500
Date: Thu, 13 Jan 2005 22:43:20 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113214320.GB22208@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com> <200501112251.j0BMp9iZ006964@localhost.localdomain> <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us> <20050112074906.GB5735@devserv.devel.redhat.com> <87oefuma3c.fsf@sulphur.joq.us> <20050113072802.GB13195@devserv.devel.redhat.com> <878y6x9h2d.fsf@sulphur.joq.us> <20050113210750.GA22208@devserv.devel.redhat.com> <1105651508.3457.31.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105651508.3457.31.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jan 13, 2005 at 04:25:08PM -0500, Lee Revell wrote:
> The basic issue is that the current semantics of SCHED_FIFO seem make
> the deadlock/data corruption due to runaway RT thread issue difficult.
> The obvious solution is a new scheduling class equivalent to SCHED_FIFO
> but with a mechanism for the kernel to demote the offending thread to
> SCHED_OTHER in an emergency. 

and this is getting really close to the original "counter proposal" to the
LSM module that was basically "lets make lower nice limit an rlimit, and
have -20 mean "basically FIFO" *if* the task behaves itself".

