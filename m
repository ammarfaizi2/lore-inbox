Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVL3FFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVL3FFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 00:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVL3FFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 00:05:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750748AbVL3FFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 00:05:00 -0500
Date: Fri, 30 Dec 2005 00:04:24 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230050424.GF20371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <43B4ADD0.4040906@rtr.ca> <43B4B034.20807@rtr.ca> <20051230040235.GE20371@redhat.com> <43B4B37A.6010608@rtr.ca> <43B4B42D.3040204@rtr.ca> <43B4B57C.60803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B4B57C.60803@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 11:20:12PM -0500, Mark Lord wrote:
 > Mark Lord wrote:
 > ..
 > >And tonight it appears to be working again (/proc/cpuinfo showing
 > >correct values, something it was not doing when I first checked it
 > >after upgrading to -rc7.. something buggy there??).
 > 
 > Okay, I've tried a couple of reboots, and it's working fine tonight.
 > Maybe it only fails when doing a public demo for Windows people?
 > (as when it first failed).
 > 
 > Leave it.  If I can catch it again, I'll scream again then.

One thing that could explain it.. SMP kernels currently don't
report scaling correctly. It'll always show the boot frequency.
There's a fix for this in the cpufreq.git repo (and -mm)
that's going to Linus once 2.6.15 is out.

		Dave

