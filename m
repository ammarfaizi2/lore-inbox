Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSFSL6m>; Wed, 19 Jun 2002 07:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSFSL6l>; Wed, 19 Jun 2002 07:58:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63752 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317859AbSFSL6k>; Wed, 19 Jun 2002 07:58:40 -0400
Date: Wed, 19 Jun 2002 07:53:44 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
In-Reply-To: <3D085D07.4DC40FF3@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1020619074816.1119G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Helge Hafting wrote:

> Why not let the boot process select the highest of two numbers,
> the (default-low) NR_CPUS and the number of CPU's detected?

That seems to address the issue. It allows use of all CPUs  in the most
common case that they all are in and working at boot.
 
> Boot with "too many" cpu's and you still get to use them - you
> merely can't hotplug even more.  

My impression is that a fair number of users don't add CPUs anyway, they
swap problem parts if runtime diagnostics indicate a failing
{fan,VRM,other}.
 
> Configuring a high NR_CPUS becomes something only hot-pluggers
> need to do, or those whose architecture doesn't support
> cpu detection in the early boot process.  Those with a fixed
> number of detectable CPUs can simply go with a default of 
> NR_CPUS=2 no matter what they actually have.

Since this would be init code the size is not an issue. I guess a
boot-time option would be desirable in case a site wants to boot with
fewer processors than are physically present (like mem=) for some reason
like benchmarking.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

