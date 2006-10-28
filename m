Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWJ1ULl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWJ1ULl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWJ1ULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:11:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13275 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964810AbWJ1ULl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:11:41 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 13:11:14 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <200610281233.27588.ak@suse.de> <20061028200439.GB1603@1wt.eu>
In-Reply-To: <20061028200439.GB1603@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281311.14665.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 13:04, Willy Tarreau wrote:

> I really think that the hardware was doing tricks far beyond my knowledge,
> because on another Sun (a V40Z), there were 4 dual cores which I never saw
> out of sync even after hours of testing. But the HPET was available in it,
> I don't remember if it's used by default when detected.

I think some system occasionally ramp the clock for thermal management,
but that should be rare.

> No I did not "force" anything at first. You take the RHEL3 CD, you install
> it, reboot and watch your logs report negative times, then scratch your
> head, first call red hat dumb ass, and after a few tests, apologize to the
> poor innocent red hat 

Well they should have fixed the kernel to fall back to another clock
by backporting the appropiate fixes from mainline. I assume they
did actually.

> and call the box a total crap. To put it shortly 
> (might be useful for people who Google for it) : Dual-core Sun x2100 is
> unreliable out of the box under Linux.

No that shouldn't be true with any modern kernel. It will just fallback
to HPET or more likely PMtimer.

>
> > In the default configuration there shouldn't be any problems
> > like this, it will just run slower because the kernel falls back to a
> > slower time source.
>
> You have to specify "notsc" for this.

No, the kernel should work out of the box. Some older kernels didn't
at various points of time though.

-Andi
