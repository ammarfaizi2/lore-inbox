Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbTFSRaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbTFSRaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:30:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22774 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265859AbTFSRaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:30:16 -0400
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	sks
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16DB3@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB3@orsmsx116.jf.intel.com>
Content-Type: text/plain
Message-Id: <1056044580.8770.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 19 Jun 2003 10:43:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 23:52, Perez-Gonzalez, Inaky wrote:

> Then some output would show on my serial console when events/0 is
> reprioritized...
> 
> OTOH, what do you think of Robert's idea of adding 20 levels of
> priorities for the kernel's sole use?

That was your idea, I just said the infrastructure was in place and we
could do it ;-)

I am not so sure it is ideal. I hesitate to make kernel threads FIFO at
a maximum priority, let alone an even greater one. I would really prefer
to find a nicer solution. Anyhow, if we make events FIFO/99 that would
also solve the problem, without dipping into extra high levels.

	Robert Love

