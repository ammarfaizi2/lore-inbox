Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUIYNuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUIYNuY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUIYNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:50:24 -0400
Received: from p5089F3FB.dip.t-dialin.net ([80.137.243.251]:2052 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269333AbUIYNuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:50:22 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: OOM-killer killed everything
Date: Sat, 25 Sep 2004 15:50:20 +0200
User-Agent: KMail/1.7
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200409251326.13915.petkov@uni-muenster.de> <Pine.LNX.4.53.0409251553420.11618@musoma.fsmlabs.com> <20040925125707.GO9106@holomorphy.com>
In-Reply-To: <20040925125707.GO9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409251550.20587.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 14:57, William Lee Irwin III wrote:
> On Sat, 25 Sep 2004, William Lee Irwin III wrote:
> >> Usually I only get "Kernel panic: Out of memory and no killable
> >> processes..." from local DoS testcases; I'd be surprised if anyone
> >> tripped over such cases by accident unless they're doing something
> >> particularly stressful (e.g. forking server with zillions of clients) or
> >> there's a
> >> particularly outrageously offensive memory leak.
>
> On Sat, Sep 25, 2004 at 03:54:59PM +0300, Zwane Mwaikambo wrote:
> > The burning CD audio one is a known issue afaik, i've run into it before
> > too.
>
> That would be the particularly outrageously offensive memory leak, then.
>
>
> -- wli

Thanks to you all guys for the help, I've applied the 2 akpm mm3 patches for 
the 2.6.8.1.  I'll try to repeat the stress test and burn an audio cd at the 
same time but I think not freeing pages of unaligned audio frames while 
burning an audio cd was the reason for the memory leak.

Regards,
Boris.
