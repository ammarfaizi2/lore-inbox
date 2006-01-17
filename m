Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWAQOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWAQOAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWAQOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:00:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40136 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932493AbWAQOAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:00:51 -0500
Date: Tue, 17 Jan 2006 15:00:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Dave C Boutcher <sleddog@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060117140050.GA13188@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <200601180032.46867.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601180032.46867.michael@ellerman.id.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael Ellerman <michael@ellerman.id.au> wrote:

> On Tue, 17 Jan 2006 08:52, Dave C Boutcher wrote:
> > 2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
> > following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch
> >
> > If I revert just that patch, mm4 boots fine.  Its really not obvious to
> > me at all why that patch is breaking things though...
> 
> My POWER5 (gr) LPAR seems to boot ok (3 times so far) with that patch, 
> guess it's something subtle. That's with CONFIG_DEBUG_MUTEXES=y. And 
> it's just booted once with CONFIG_DEBUG_MUTEXES=n.
> 
> And now it's booted the full mm4 patch set without blinking.

so it booted fine with CONFIG_DEBUG_MUTEXES=n but with that patch not 
applied?

the patch will likely work around the bug, so DEBUG_MUTEXES=y/n should 
make no difference with that patch applied.

	Ingo
