Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVGOCcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVGOCcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVGOCcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:32:07 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:15844 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S263152AbVGOCcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:32:05 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121383050.4535.73.camel@mindpipe>
	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
	 <1121384499.4535.82.camel@mindpipe>
	 <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1121394653.19939.775.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2005 19:30:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 16:49, Linus Torvalds wrote:
> On Thu, 14 Jul 2005, Lee Revell wrote:
> > 
> > And I'm incredibly frustrated by this insistence on hard data when it's
> > completely obvious to anyone who knows the first thing about MIDI that
> > HZ=250 will fail in situations where HZ=1000 succeeds.
> 
> Ok, guys. How many people have this MIDI thing? How many of you can't be 
> bothered to set the default to suit your usage?
> 
> > It's straight from the MIDI spec.  Your argument is pretty close to "the
> > MIDI spec is wrong, no one can hear the difference between 1ms and 4ms".
> 
> No.
> 
> YOUR argument is "nobody else matters, only I do".
> 
> MY argument is that this is a case of give and take. 

Take from "few" multimedia users, give to "many" laptop users. Where
"few" and "many" are not very well defined quantities, but obviously
"many" > "few" :-) 

As to how few is few. I don't claim to know, but users that bother to
subscribe to the Planet CCRMA[*] mailing list number 750+, so that's one
datapoint. Total users of Planet CCRMA, I have no idea. Most of them
will use MIDI, either externally through hardware interfaces or
internally through the ALSA sequencer api. 

Planet CCRMA includes custom kernels with Ingo's patches for low
latency, so I will have to configure them with HZ=1000 (or 500 or
whatever) in 2.6.13+. Oh well. 

HZ=250 is a setback anyway, as many advances had been made recently in
the stock kernel that made it more and more suitable to multimedia work
(_GREAT_ work BTW). That raised my hopes that, eventually, I would not
have to build kernels, just apps, as stock kernels would be good enough.
This will make the wait longer. 

Sigh, I'll be patient and dream about high resolution timers or other
technically elegant solutions that will not penalize multimedia apps or
laptops... 

-- Fernando

[*] http://ccrma.stanford.edu/planetccrma/software/


