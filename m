Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTIOL6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTIOL6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:58:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36878 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261271AbTIOL6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:58:01 -0400
Date: Mon, 15 Sep 2003 07:48:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030915074616.19165B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, John Bradford wrote:

    [... many good points ...]

> This makes it trivial to:
> 
> * Make a kernel for a distribution's initial install
>   Select all CPUs as supported, and optimise for 686.
> 
> * Make an optimised kernel for any system
>   Select only the target CPU as supported, and optimise for it
> 
> * Make a generic kernel for PIV, and Athlon
>   Select PIV and Athlon only as supported.  Optimise for either, or
>   optimise for 386, (yes, even though it is not supported), for a
>   small kernel, on the basis that it will maximise cache usage, and be
>   fairly optimal on both systems.

That last is a good point for sure, I have seen several posts indicating
that -Os is faster on small cache machines like old Celerons, it would be
a sensible choice for a distro, and make the kernel smaller as well.
Kernels are getting near the limits of some machines to boot them.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

