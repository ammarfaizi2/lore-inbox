Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUCEQr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUCEQr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:47:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60103 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262645AbUCEQrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:47:55 -0500
Date: Fri, 5 Mar 2004 17:49:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: andrea@suse.de, peter@mysql.com, akpm@osdl.org, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305164902.GA17745@elte.hu>
References: <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <p73ad2v47ik.fsf@brahms.suse.de> <20040305162319.GA16835@elte.hu> <20040310142125.6f448d28.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310142125.6f448d28.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > [...] Only drawback is that if a timer tick is delayed for too long it
> > > won't fix that, but I guess that's reasonable for a 1s resolution.
> > 
> > what do you mean by delayed?
> 
> Normal gettimeofday can "fix" lost timer ticks because it computes the
> true offset to the last timer interrupt using the TSC or other means.
> xtime is always the last tick without any correction. If it got
> delayed too much the result will be out of date.

yeah - i doubt the softirq delay is a real issue.

	Ingo
