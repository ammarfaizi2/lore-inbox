Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUJTHnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUJTHnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUJTHhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:37:51 -0400
Received: from fmr99.intel.com ([192.55.52.32]:5778 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S269012AbUJTHfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:35:45 -0400
Subject: Re: [PATCH] cpufreq_ondemand
From: Len Brown <len.brown@intel.com>
To: Andre Eisenbach <int2str@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Alexander Clouter <alex-kernel@digriz.org.uk>,
       "cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
In-Reply-To: <7f800d9f04101922031be5cfe8@mail.gmail.com>
References: <7f800d9f04101922031be5cfe8@mail.gmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098257735.26595.4308.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 03:35:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 01:03, Andre Eisenbach wrote:

> ... If the
> speed steps down slowly but shoots up 100% quickly (as it is right
> now), even a small task (like opening a folder, or scrolling down in a
> document) will cause a tiny spike to 100% which takes a while to go
> back down. The result is that the CPU spends most of it's time at 100%
> or calming down. I wrote a small test program on my notebook which
> confirms this.

The question is what POLICY we're trying to implement.  If the goal is
to to be energy efficient while the user notices no performance hit,
then fast-up/slow-down is an EXCELLENT strategy.  But if the goal is to
optimize for power savings at the cost of impacting performance, then
another strategy may work better.

The point is that no strategy will be optimal for all policies.  Linux
needs a global power policy manager that the rest of the system can ask
about the current policy.  This way sub-systems can (automatically)
implement whatever local strategies are consistent with that global
policy.

-Len


