Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVCSHvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVCSHvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 02:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVCSHvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 02:51:45 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:9858 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262428AbVCSHvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 02:51:44 -0500
Subject: Re: Latency tests with 2.6.12-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20050319070810.GA20059@elte.hu>
References: <1111204984.12740.22.camel@mindpipe>
	 <20050319070810.GA20059@elte.hu>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 02:51:42 -0500
Message-Id: <1111218702.13039.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 08:08 +0100, Ingo Molnar wrote:
> great! The change in question is most likely the copy_page_range() fix
> that Hugh resurrected:
> 
> ChangeSet 1.2037, 2005/03/08 09:26:46-08:00, hugh@veritas.com
> 
> 	[PATCH] copy_pte_range latency fix
> 	
> 	Ingo's patch to reduce scheduling latencies, by checking for lockbreak in
> 	copy_page_range, was in the -VP and -mm patchsets some months ago; but got
> 	preempted by the 4level rework, and not reinstated since. Restore it now
> 	in copy_pte_range - which mercifully makes it easier.
> 
> are the ext3 related latencies are gone as well - or are you working it
> around by not using data=ordered?

As a matter of fact the ext3 latencies do not appear to be causing
problems, at least not at those settings, even with data=ordered.

It's impossible to tell much more because the mainline kernel lacks the
instrumentation that the realtime patchset provides.

Lee



