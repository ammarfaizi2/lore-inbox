Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUDLQqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDLQqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:46:51 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36547 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262981AbUDLQqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:46:49 -0400
Date: Mon, 12 Apr 2004 12:47:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [0/3]
In-Reply-To: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
Message-ID: <Pine.LNX.4.58.0404121246310.18930@montezuma.fsmlabs.com>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Thorsten Kranzkowski wrote:

> With every 2.6 kernel I tried the system speaker on my Alpha produces a
> rather unpleasant high pitched tone instead of the normal system beep.
> This is because in p|cspkr.c the calculation of the counter values is
> incorrectly based on CLOCK_TICK_RATE.
> To solve this problem I came up with these tree patches:
>
> 1/3:	introduce PIC_TICK_RATE constant. It seems this is not always
> 	the same value.
> 2/3:	use PIC_TICK_RATE in *spkr.c and some other places where the
> 	PIC is directly programmed.
> 3/3:	use CLOCK_TICK_RATE where 1193180 was used in timing calculations.
>
> Tested on Alpha, compile & boot-tested on i386 (unrelated LVM problems here)
>
> Arch maintainers please have a look whether I got the constants right or
> if your architecture has a PIC at all.

Isn't this supposed to be PIT_TICK_RATE?
