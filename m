Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWBWSKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWBWSKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBWSKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:10:49 -0500
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:32999 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750717AbWBWSKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:10:49 -0500
Date: Thu, 23 Feb 2006 13:07:30 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: warn if unable to configure apic main
  timer
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602231310_MC3-1-B917-8A34@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200602231024.38599.ak@suse.de>

On Thu, 23 Feb 2006 at 10:24:38 +0100, Andi Kleen wrote:
> On Thursday 23 February 2006 10:17, Chuck Ebbert wrote:
> > When using the APIC main timer option on x86_64, sometimes it
> > fails to complete its setup.  Warn about this and suggest
> > the user try 'disable_timer_pin_1' if their system clock runs
> > too fast. Also, make printing of the exact result of APIC
> > timer calibration require 'apic=verbose'.
> 
> This is not the right solution. Have to find out what's going
> wrong and fix that.
> 

 I was thinking of this more as a band-aid for 2.6.16.

 But this patch is broken anyway; it will print the message on
non-bootstrap CPUs.

> I'm also experimenting with a different way to run the timer
> because apicmaintimer doesn't work on a lot of laptops
> because they have trouble running the APIC timer during c2.

 Yeah, I saw the Intel patch that does the exact opposite of
apicmaintimer.  It's kind of funny having both of them in there.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

