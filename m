Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUA0HT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUA0HT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:19:56 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:8074 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262683AbUA0HTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:19:55 -0500
Date: Mon, 26 Jan 2004 23:19:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
Message-ID: <361670000.1075187987@[10.10.2.4]>
In-Reply-To: <4015F9A8.6000801@cyberone.com.au>
References: <20040127024049.7B90B2C13D@lists.samba.org> <356230000.1075178284@[10.10.2.4]> <4015F9A8.6000801@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well lets not worry too much about this for now. We could use
> static arrays and cpu_possible for now until we get a feel
> for what specific architectures want.
> 
> To be honest I haven't seen the hotplug CPU code and I don't
> know about what architectures want to be doing with it, so
> this is my preferred direction just out of ignorance.
> 
> An easy next step toward a dynamic scheme would be just to
> re-init the entire sched domain topology (the generic init uses
> the generic NUMA topology info which will have to be handled
> by these architectures anyway). Modulo a small locking problem.
> 
> There aren't any fundamental design issues (with sched domains)
> that I can see preventing a more dynamic system so we can keep
> that in mind.

Yeah, I talked it over with Rusty some on IRC. I have more of a feeling
why he's trying to do it that way now. However, one other thought occurs
to me ... it'd be good to use the same infrastructure (sched domains)
for the workload management stuff as well (where the domains would be
defined from userspace). That'd also necessitate them being dynamic,
if you think that'd work out as a usage model.

The cpu_possible stuff might work for a first cut at hotplug I guess.
I still think it's ugly though ;-)

M.

