Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268461AbUHLIJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268461AbUHLIJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 04:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268459AbUHLIJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 04:09:07 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61419 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268461AbUHLIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 04:09:02 -0400
Date: Thu, 12 Aug 2004 04:12:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <20040812072058.GH11200@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0408120401010.2544@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org>
 <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com>
 <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com>
 <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, William Lee Irwin III wrote:

> On Wed, Aug 11, 2004 at 07:04:24PM -0700, William Lee Irwin III wrote:
> > Odd, it was either you or mpm who told me the results. I personally
> > never even tried running the thing. I was merely told some other, prior
> > attempt at doing some kind of spinlock uninlining failed to run, this
> > thing did, and that it shaved that memorable amount off of .text size.
> > I recall I compiled it myself and saw about half as much reduction
> > (120KB instead of 220KB), possibly due to .config or compiler differences.
> > I'll dust things off and so on.
>
> Okay, the results on 2.6.8-rc4 (COOL had a bit of porting, basically
> dropping the hunks associated with spin_lock_flags_string or whatever
> it is). Chose the .config largely to be vaguely deterministic, but had
> to nuke the "System is too big" check in arch/x86_64/boot/tools/build.c.
>
>               text    data     bss     dec     hex filename
> mainline: 20708323        6603052 1878448 29189823        1bd66bf vmlinux
> cool:     20619594        6588166 1878448 29086208        1bbd200 vmlinux
> C-func:   19969264        6583128 1878384 28430776        1b1d1b8 vmlinux

Shit that's quite the variance, which compiler are you using?
