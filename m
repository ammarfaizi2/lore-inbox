Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbTJUT4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJUT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:56:11 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:56007 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263254AbTJUT4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:56:08 -0400
Message-ID: <1066766155.a66ff46274f08@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 21 Oct 2003 12:55:55 -0700
From: Carl Thompson <cet@carlthompson.net>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: arjanv@redhat.com, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       Dominik Brodowski <linux@brodo.de>, linux-acpi <linux-acpi@intel.com>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to
	ACPIP-state driver
References: <7F740D512C7C1046AB53446D3720017304B031@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304B031@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.174
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Nakajima, Jun" <jun.nakajima@intel.com>:

> ...

> It's about the frequency of the feedback loop. As we have much lower
> latency with P-state transitions, the sampling time can be order of
> millisecond (or shorter if meaningful). A userland daemon can have a
> high-level policy (preferences, or set of parameters), but it cannot be
> part of the real feedback loop. If we combine P-state transitions and
> deeper C-state transitions, the situation is worse with a userland
> daemon.

You are making the assumption that a higher polling frequency (we'll say
1ms) is in general better than a lower frequency (we'll say 1s).  I submit
that it is not.

If I hit a key on my keyboard and your high frequency loop increases CPU
speed so that my word processor displays the letter 0.01s faster, is that
really beneficial?  If a window renders in 0.2s seconds instead of 0.3s is
that a difference I am going to notice?

On the other hand, if I do a kernel compile and it is done 0.999s faster
with the higher frequency loop, am I going to miss that second over such a
long duration?  (In reality, the compile with the high-frequency loop would
probably take longer unless it has near zero overhead).

In my opinion it is wasteful to increase CPU speed unless there is a longer
term need for it.

> 	Jun

Carl Thompson


