Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUCEQe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUCEQez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:34:55 -0500
Received: from ns.suse.de ([195.135.220.2]:28832 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262642AbUCEQey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:34:54 -0500
Date: Wed, 10 Mar 2004 14:21:25 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: andrea@suse.de, peter@mysql.com, akpm@osdl.org, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040310142125.6f448d28.ak@suse.de>
In-Reply-To: <20040305162319.GA16835@elte.hu>
References: <20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
	<20040305103308.GA5092@elte.hu>
	<20040305141504.GY4922@dualathlon.random>
	<20040305143425.GA11604@elte.hu>
	<20040305145947.GA4922@dualathlon.random>
	<20040305150225.GA13237@elte.hu>
	<p73ad2v47ik.fsf@brahms.suse.de>
	<20040305162319.GA16835@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 17:23:19 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > [...] Only drawback is that if a timer tick is delayed for too long it
> > won't fix that, but I guess that's reasonable for a 1s resolution.
> 
> what do you mean by delayed?

Normal gettimeofday can "fix" lost timer ticks because it computes the true
offset to the last timer interrupt using the TSC or other means. xtime
is always the last tick without any correction. If it got delayed too much 
the result will be out of date.

-Andi
