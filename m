Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRCaFpw>; Sat, 31 Mar 2001 00:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132312AbRCaFpm>; Sat, 31 Mar 2001 00:45:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:4039 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S132301AbRCaFp3>;
	Sat, 31 Mar 2001 00:45:29 -0500
Message-Id: <200103310544.f2V5icO07172@pcug.org.au>
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled using 45% CPU (why not 100%?) 
In-Reply-To: Your message of Sat, 31 Mar 2001 03:35:04 +0200.
             <20010331033504.A7022@pcep-jamie.cern.ch> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2409.986017478.1@rustcorp.com.au>
Date: Sat, 31 Mar 2001 15:44:38 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> Subject says it all.  On my laptop which is running 2.4.0, while the
> machine is completely idle "top" reports kapm-idled as usin about 45% of
> the CPU.  The remaining 55% is reported as idle time.

This is normal behaviour ... the current implementation of kapm-idled
means that it is sleeping some of the time, so the real idle process
actually gets some time.  I did a patch a while ago the got the kapm-idled
up to about 93-95%, but I didn;t think i was all that important.

> When the machine gets a little more active, the CPU time attributed to
> kapm-idled decreases while the 55% idle time increases to 85%!

Again this is normal (although it may not seem sensible).

> This is not caused be "top": I get the same 45% from "ps -l 3".
> 
> I remember when kapmd was reporting 100%.  Is the new behaviour
> intentional, and is it saving the maximum power on the laptop?

I have NEVER seen kapmd getting 100%.  You are probably getting
about as good power saving as you will get (unfortunately) although
don't hold me to that - I have heard of some laptops that get better
power savings when CONFIG_APM_CPU_IDLE was NOT set ...

Cheers,
Stephen
