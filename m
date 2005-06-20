Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVFUAFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFUAFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFUADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36803 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261191AbVFTXl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:41:29 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1119304422.9947.90.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <1119291034.16180.9.camel@mindpipe>
	 <1119304422.9947.90.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 19:44:56 -0400
Message-Id: <1119311096.17701.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 14:53 -0700, john stultz wrote:
> Yea, honestly I doubt gettimefoday performance will ever be as good as
> rdtsc. I mean, that's a single instruction vs syscall overhead +
> hardware clock reading + frequency conversion + ntp adjustment. Its
> just not a fair comparison.  

Of course not, the patch would have to be magic for that to happen.  

But some user space apps are now *required* to use rdtsc for timing due
to the massive performance difference.  If we only took a 5x or 10x
performance hit vs rdtsc, rather than the current 50x, it might be
enough that user space apps won't have to do this.

Lee

