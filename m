Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVJVDlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVJVDlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 23:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVJVDlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 23:41:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36297 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932580AbVJVDlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 23:41:11 -0400
Date: Sat, 22 Oct 2005 05:41:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       William Weston <weston@lysdexia.org>, cc@ccrma.stanford.edu,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051022034119.GA12751@elte.hu>
References: <20051018072844.GB21915@elte.hu> <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org> <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu> <20051020191620.GA21367@elte.hu> <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu> <5bdc1c8b0510211720q28334177p1b6d6a2cd7fbfd67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510211720q28334177p1b6d6a2cd7fbfd67@mail.gmail.com>
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


* Mark Knecht <markknecht@gmail.com> wrote:

> On 10/21/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> <SNIP>
> >
> > Here's one with rc5-rt3:
> >
> > Oct 21 15:01:46 cmn3 kernel: BUG: ktimer expired short without user
> > signal! (hald-addon-stor:4309)
> > Oct 21 15:01:46 cmn3 kernel: .. expires:   1012/751245500
> > Oct 21 15:01:46 cmn3 kernel: .. expired:   1012/750908115
> > Oct 21 15:01:46 cmn3 kernel: .. at line:   942
> > Oct 21 15:01:46 cmn3 kernel: .. interval:  0/0
> ><SNIP>
> 
> Refresh me. What sort of machine is this and what log file are you 
> seeing these in. I am surprised at my not seeing them at all, but I 
> have not gone into the high res timer stuff much. Should I?

high-res timers are not ported (and thus not switchable via the .config) 
to x64, yet - so you are much less likely to be seeing such problems.  
x64 does run the generic ktimer code - but this particular problem seems 
to be related to hres timers.

	Ingo
