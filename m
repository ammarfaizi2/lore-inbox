Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbTIOIR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTIOIR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:17:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:56704 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261633AbTIOIR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:17:58 -0400
Date: Mon, 15 Sep 2003 09:31:44 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309150831.h8F8Vir6000839@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, john@grabjohn.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's a non-issue.  300 bytes matters a lot on some systems.  The
> > fact that there are drivers that are bloated is nothing to do with
> > it.
>
> Its kind of irrelevant when by saying "Athlon" you've added 128 byte
> alignment to all the cache friendly structure padding.

My intention is that we won't have done 128 byte alignments just by
'supporting' Athlons, only if we want to run fast on Athlons.  A
distribution kernel that is intended to boot on all CPUs needs
workarounds for Athlon bugs, but it doesn't need 128 byte alignment.

Obviously using such a kernel for anything other than getting a system
up and running to compile a better kernel is a Bad Thing, but the
distributions could supply separate Athlon, PIV, and 386 _optimised_
kernels.

> There are systems
> where memory matters, but spending a week chasing 300 bytes when you can
> knock out 50K is a waste of everyones time. Do the 40K problems first

The 'select a single CPU to support and/optimise for' -> 'select a
bitmap of CPUs to support' work is being done anyway though, so this
is more or less just one single IFDEF, which is more like a few
seconds work, rather than a week.

Also, a lot of the 40K problems are in drivers that embedded systems
simply don't use.

John.
