Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVHWFqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVHWFqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 01:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHWFqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 01:46:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35782 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751321AbVHWFqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 01:46:00 -0400
Date: Tue, 23 Aug 2005 07:46:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050823054609.GA26707@elte.hu>
References: <1124323379.5186.18.camel@localhost.localdomain> <1124333050.5186.24.camel@localhost.localdomain> <20050822075012.GB19386@elte.hu> <1124704837.5208.22.camel@localhost.localdomain> <20050822101632.GA28803@elte.hu> <1124710309.5208.30.camel@localhost.localdomain> <20050822113858.GA1160@elte.hu> <1124715755.5647.4.camel@localhost.localdomain> <20050822183355.GB13888@elte.hu> <1124739657.5809.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124739657.5809.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Here's a patch to move the pi_lock out of the "fast path".  Thus, only 
> threads that need to do PI will need to take it.

ok, looks good, applied it. I've renamed p->rt_lock to p->pi_lock. The 
patch gave a 10% wall-clock improvement in hackbench numbers on an 8-way 
box. (This box has pretty high cachemiss costs, so the positive effects 
of such patches show up nicely.)

	Ingo
