Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVD1DpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVD1DpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 23:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVD1DpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 23:45:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30444 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261883AbVD1DpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 23:45:16 -0400
Subject: Re: [RFC][PATCH] Reduce ext3 allocate-with-reservation lock
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1114207837.7339.50.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 23:45:12 -0400
Message-Id: <1114659912.16933.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-22 at 15:10 -0700, Mingming Cao wrote:
> Please review. I have tested on fsx on SMP box. Lee, if you got time,
> please try this patch.

I have tested and this does fix the problem.  I ran my tests and no ext3
code paths showed up on the latency tracer at all, it never went above
33 usecs.

Please apply.

Lee

