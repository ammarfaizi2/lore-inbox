Return-Path: <linux-kernel-owner+w=401wt.eu-S1753655AbWL0ShD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbWL0ShD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 13:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbWL0ShD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 13:37:03 -0500
Received: from homer.mvista.com ([63.81.120.158]:2092 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbWL0ShB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 13:37:01 -0500
Subject: Re: [PATCH -rt] disconnect warp check from hrtimers
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1167242644.14081.33.camel@imap.mvista.com>
References: <20061227172828.998757000@mvista.com>
	 <20061227173957.GA18900@elte.hu>
	 <1167242010.14081.31.camel@imap.mvista.com>
	 <1167242644.14081.33.camel@imap.mvista.com>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 10:36:18 -0800
Message-Id: <1167244578.14081.37.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 10:04 -0800, Daniel Walker wrote:
> On Wed, 2006-12-27 at 09:53 -0800, Daniel Walker wrote:
> 
> > The system hang was resolved by changing the irq threads to all prio
> > 50 ..
> 
> Guess I was wrong about this.. The hang was resolved, but I's not sure
> how yet ..

Looks like it was the irq thread priority _and_ the softirq prio needed
to be raised. softirq was at SCHED_FIFO 1 which caused the hang (or
that's how it looks).

Daniel

