Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFFHt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFFHt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVFFHtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:49:24 -0400
Received: from fmr18.intel.com ([134.134.136.17]:17848 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261196AbVFFHsF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:48:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Real-Time Preemption, plist fixes
Date: Mon, 6 Jun 2005 00:44:45 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A037001B3@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Real-Time Preemption, plist fixes
Thread-Index: AcVp1Xoa2jf9y0AZQ6qJ+0xG4yLPWAAlb3GA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Esben Nielsen" <simlo@phys.au.dk>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
       "Daniel Walker" <dwalker@mvista.com>, "Oleg Nesterov" <oleg@tv-sign.ru>
X-OriginalArrivalTime: 06 Jun 2005 07:47:33.0651 (UTC) FILETIME=[FFDAEE30:01C56A6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>
>so the question is - can we have an extreme (larger than 140) number of
>RT tasks? If yes, why are they all RT - they can have no expectation of
>good latencies with a possible load factor of 140!

In practice, didn't we want most tasks to behave like RT?
(for interactivity purposes) -- I recall hearing that's basically
what good interactivity meant; short reponse times to events.

So then, taking await batch/bacground data-munching jobs, we fold 
back to needing a good RT-like behaviour. And then we can reach > 140.

-- Inaky
