Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVGMWJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVGMWJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGMSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:43:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:187 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262219AbVGMSmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:42:12 -0400
Date: Wed, 13 Jul 2005 20:42:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Lang <david.lang@digitalinsight.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050713184227.GB2072@ucw.cz>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 10:24:10AM -0700, David Lang wrote:

> >How serious is the 1/HZ = sane problem, and more to the point how many 
> >programs get the HZ value with a system call as opposed to including a 
> >header or building it in? I know some of my older programs use header 
> >files, that was part of the planning for the future even before 2.5 
> >started. At the time I didn't expect to have to use the system call.
> 
> in binary 1/100 or 1/1000 are not sane values to start with so I don't 
> think that that this is likly to be that critical (remembering that the 
> kernel doesn't do floating point math)
 
No, but 1/1000Hz = 1000000ns, while 1/864Hz = 1157407.407ns. If you have
a counter that counts the ticks in nanoseconds (xtime ...), the first
will be exact, the second will be accumulating an error.

It's a tradeoff.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
