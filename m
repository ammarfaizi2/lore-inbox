Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbVLWVKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbVLWVKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbVLWVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:10:39 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:32648 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1161055AbVLWVKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:10:39 -0500
Date: Fri, 23 Dec 2005 21:19:02 +0000
From: John Rigg <lk@sound-man.co.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Rigg <lk@sound-man.co.uk>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost a preemption check!
Message-ID: <20051223211902.GA4831@localhost.localdomain>
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com> <1135352277.6652.2.camel@localhost.localdomain> <20051223174744.GA4518@localhost.localdomain> <1135370321.5774.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135370321.5774.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 03:38:41PM -0500, Steven Rostedt wrote:
> OK, here's your problem (I didn't notice this at first and went through
> a series of printks to see this).   NUMA isn't supported yet by -rt.
> Turn it off and give it another try.

Thanks, Steve, this fixed it. I was reusing a .config from previous
versions, originally derived from a Ubuntu .config which had NUMA
enabled. It booted and ran with previous -rt's so I didn't realise it was 
a problem.

John
