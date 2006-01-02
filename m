Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWABUlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWABUlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWABUlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:41:02 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31703 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751059AbWABUlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:41:00 -0500
Date: Mon, 2 Jan 2006 21:40:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: khc@pm.waw.pl, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102204048.GB1131@elte.hu>
References: <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org> <20060102200934.GA30093@elte.hu> <20060102122441.54139453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102122441.54139453.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > i marked all things __always_inline that allyesconfig 
> >  needs inlined.
> 
> I hope you fixed __always_inline too.  It's currently a no-op on all 
> but alpha.

yeah, i fixed that, my patch-queue does:

#define __always_inline         inline __attribute__((always_inline))

	Ingo
