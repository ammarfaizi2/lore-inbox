Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbUAEXbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUAEXbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:31:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23520 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265976AbUAEXbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:31:21 -0500
Subject: Re: [2.6.0-mm2] PM timer still has problems
From: john stultz <johnstul@us.ibm.com>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040105231833.GA12844@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl>
	 <1073340716.15645.96.camel@cog.beaverton.ibm.com>
	 <20040105221758.GA13727@hell.org.pl>
	 <1073341969.15645.106.camel@cog.beaverton.ibm.com>
	 <20040105231833.GA12844@hell.org.pl>
Content-Type: text/plain
Message-Id: <1073345444.15645.132.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 15:30:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 15:18, Karol Kozimor wrote:
> Thus wrote john stultz:
> > Ah, I must have missed that point. Indeed that is very odd. When booting
> > without the clock= what time source is used? Does booting w/
> > "clock=crazy" also show the problem?
> 
> A quick follow-up: booting with 2.6.1-rc1 + plus your patch:
> clock=crazy: doesn't even pass the Uncompressing kernel... Booting Linux 
>              stage,

Grrr. That def shouldn't happen. Let me do some further local testing
and I'll get back to you with another patch. 

> clock=pmtmr: see above

Expected, as 2.6.1-rc1 doesn't have the ACPI pm time source, so
pmtmr=crazy ;)

> clock=tsc  : boots normally
> clock=pit  : as well

I'm still curious about what default time source is selected (when not
using the clock= option) using 2.6.1-rc1-mm1. As well as what happens
there w/ clock=crazy.

thanks so much for the feedback.
-john



