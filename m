Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTFLObY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264831AbTFLObY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:31:24 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:38823 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264830AbTFLObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:31:23 -0400
Date: Thu, 12 Jun 2003 15:44:50 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030612144450.GD8146@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mark Watts <m.watts@eris.qinetiq.com>,
	John Goerzen <jgoerzen@complete.org>, linux-kernel@vger.kernel.org
References: <87n0go3pcp.fsf@complete.org> <20030612061803.GA21509@suse.de> <200306121510.01876.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306121510.01876.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:10:01PM +0100, Mark Watts wrote:

 > Thought this may help:
 > - From a Dell D600 w/ 1.6Ghz Pentium M cpu...

Yep, the latest bunch of cache descriptors are missing from 2.4
(They're in 2.5 already). I did send these to Marcelo, but they
seem to have got lost when we entered -rc stage.
I'll resend them for 2.4.22pre

 > 
 > unknown TLB/cache descriptor:
 >         0xb0
 > unknown TLB/cache descriptor:
 >         0xb3

uninteresting (tlb sizes)

 > Instruction TLB: 4MB pages, fully associative, 2 entries
 > unknown TLB/cache descriptor:
 >         0x87

1MB l2 unified cache.

 > unknown TLB/cache descriptor:
 >         0x30

32KB L1 I cache

 > Data TLB: 4MB pages, 4-way associative, 8 entries
 > unknown TLB/cache descriptor:
 >         0x2c

32KB L1 D cache

Current CVS version of x86info already supports all these too btw,
(just in case someone was tempted to hack a patch for that against 1.11).
I'll do another release sometime this weekend.

		Dave

