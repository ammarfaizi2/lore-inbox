Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbSLRF0U>; Wed, 18 Dec 2002 00:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSLRF0U>; Wed, 18 Dec 2002 00:26:20 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:27660
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S267149AbSLRF0U>; Wed, 18 Dec 2002 00:26:20 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040189657.1562.11.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Dec 2002 21:34:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 09:55, Linus Torvalds wrote:
> Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
> is the "base of sysinfo page". Right now that page is all zeroes except
> for the system call trampoline at the beginning, but we might want to add
> other system information to the page in the future (it is readable, after
> all).

The P4 optimisation guide promises horrible things if you write within
2k of a cached instruction from another CPU (it dumps the whole trace
cache, it seems), so you'd need to be careful about mixing mutable data
and the syscall code in that page.

Immutable data should be fine.
        
        J

