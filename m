Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbTFSGih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265712AbTFSGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:38:37 -0400
Received: from fmr06.intel.com ([134.134.136.7]:55256 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265713AbTFSGig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:38:36 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16DB3@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	 sks
Date: Wed, 18 Jun 2003 23:52:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Ingo Molnar [mailto:mingo@elte.hu]
> 
> On Wed, 18 Jun 2003, Perez-Gonzalez, Inaky wrote:
> 
> > My point here is: I am trying to trace where this program is making use
> > of workqueues inside of the kernel, and I can find none. The only place
> > where I need to look some more is inside the timer code, but in a quick
> > glance, it seems it is not being used, so why is it affected by the
> > reprioritization of the events/0 thread? George, can you help me here?
> 
> well, printk (console input/output) can already make use of keventd.

Then some output would show on my serial console when events/0 is
reprioritized...

OTOH, what do you think of Robert's idea of adding 20 levels of
priorities for the kernel's sole use?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

