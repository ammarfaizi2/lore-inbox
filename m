Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUAOVNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:10:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37099 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263734AbUAOVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:08:01 -0500
Date: Thu, 15 Jan 2004 21:48:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIOS Flash changes PowerNOW frequencies?
Message-ID: <20040115204847.GH467@openzaurus.ucw.cz>
References: <20040111175610.GA26855@dotnetslash.net> <20040114050818.GC23845@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114050818.GC23845@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > is "Why?". If the CPU and chipset support both sets of frequencies with
>  > different BIOS, wouldn't the _real_ set of supported frequencies be the union
>  > of the 2?
> 
> In reality, yes.
> However BIOS programmers have a different perception of reality to the rest of us.
> The spec for PST tables allows for up to 256 FID/VID pairs, yet everyone just
> seems to offer 5-6 as maximum. I guess they figured no-one needed the granularity
> of the full range.

Imagine tests needed to check that hw is stable at
each supported frequency. At that point I understand
they only support 6 of them...

> Something that has been planned for quite a while has been a means of overriding
> the tables using sysfs. I haven't had time to implement this, and no-one else
> has found the time/motivation to do so either it seems.
>

That would be nice. Both notebooks that I have do have broken
PST's... Ouch.
 
> Something I was tempted to do at one point (due to the number of broken PST's out
> there) was to offer a 'ignore_pst' module parameter, which exposed the full table
> to sysfs. The only problem being some VRMs can't handle certain frequencies at
> certain voltages whilst some can, making it hard to find a set of 'safe' values
> for each frequency.
> 
> How to find out which one VRM can handle frequency X at voltage Y ?
> Through the PST tables.

Well, you can try it, if it dies, remembed "bad combination"
else compile kernel, if it works, it probably is usable
combination... at least thats how I did it by hand on
k7 notebook.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

