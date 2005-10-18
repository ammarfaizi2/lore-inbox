Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVJRGo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVJRGo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVJRGo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:44:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751443AbVJRGo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:44:57 -0400
Date: Tue, 18 Oct 2005 08:45:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051018064517.GB21236@elte.hu>
References: <20051017160536.GA2107@elte.hu> <Pine.LNX.4.10.10510171713420.26804-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10510171713420.26804-100000@godzilla.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> The clocksource_lock should be a raw because it's locked with the raw 
> lock system_time_lock held, and interrupts are off . So it could sleep 
> with interrupts disabled. I just compile tested this, but I think it 
> should be fine .

yeah, indeed - applied.

Thomas: clocksource_lock being a seqlock is pretty pointless too right 
now, as nothing uses the read variant.

	Ingo
