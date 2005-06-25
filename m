Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbVFYC4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbVFYC4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbVFYC4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:56:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:717 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263300AbVFYC4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:56:16 -0400
Date: Sat, 25 Jun 2005 04:56:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] add suspend/resume for timer
Message-ID: <20050625025613.GD22393@atrey.karlin.mff.cuni.cz>
References: <1119496186.3325.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119496186.3325.1.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The timers lack .suspend/.resume methods. Because of this, jiffies got a
> big compensation after a S3 resume. And then softlockup watchdog reports
> an oops. This occured with HPET enabled, but it's also possible for
> other timers.
> I know Linux will introduce a new timer core system, but it maybe take a
> long time, so I send this patch to fix bugs at hand. If the new timer
> system will be merged soon, please ignore this one.

Patch looks good to me. Setting up timers as system devices was ugly,
and this fixes it. Good.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
