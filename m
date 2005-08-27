Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbVH0Tbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbVH0Tbd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 15:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbVH0Tbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 15:31:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62900 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751641AbVH0Tbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 15:31:31 -0400
Date: Sat, 27 Aug 2005 13:58:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [ACPI] acpi_shutdown: Only prepare for power off on power_off
Message-ID: <20050827115759.GB1109@openzaurus.ucw.cz>
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee> <m14q9iva4q.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508221152350.17731@math.ut.ee> <m1mznativw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508242252120.20856@math.ut.ee> <m11x4iofmw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508260802230.22690@math.ut.ee> <m1ek8htfcc.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508262144490.24024@math.ut.ee> <m1r7cfswa5.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r7cfswa5.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When acpi_sleep_prepare was moved into a shutdown method we
> started calling it for all shutdowns.  It appears this triggers
> some systems to power off on reboot.  Avoid this by only calling
> acpi_sleep_prepare if we are going to power off the system.

Are you sure that system_state is correctly set at this point? There are
quite a few ways that lead to this...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

