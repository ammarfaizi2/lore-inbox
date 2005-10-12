Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVJLGOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVJLGOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVJLGOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:14:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41874 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932471AbVJLGOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:14:45 -0400
Date: Wed, 12 Oct 2005 08:14:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051012061455.GA16586@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129064151.5324.6.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Hi Ingo, just a heads up, I'm still seeing the same problems I 
> reported with rt13. After about 10 to 15 minutes of up time I see the 
> usual warnings from Jack, keyboard repeat problems (repeats keys too 
> fast) and random screensaver triggers. The last two seem to be 
> "clustered" in time, for a little while things work, then both happen 
> and so on and so forth.
> 
> Sorry to not have any traces that could help, I'm still too busy to be 
> able to sit down quietly and gather data.

i'm not sure latency traces will uncover anything useful for this bug.  
Your problems could be timer issues: timers going off too fast cause 
high keyboard repeat rates, and the same goes for the screensaver. Does 
'sleep 1' work as expected, or is that timing out in an "accelerated" 
way too?

one tweak would be to turn off SMP support in the .config for testing 
purposes. Another tweak would be to turn HIGH_RES_TIMERS on in the 
.config - it is the common operating mode and the default, so non-HRT 
timers could have attracted some bug we didnt notice yet.

	Ingo
