Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWJ1BFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWJ1BFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 21:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWJ1BFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 21:05:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:12239 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751485AbWJ1BFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 21:05:22 -0400
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Subject: Re: AMD X2 unsynced TSC fix?
Date: Fri, 27 Oct 2006 18:04:52 -0700
User-Agent: KMail/1.9.1
Cc: Luca Tettamanti <kronos.it@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan> <20061027230458.GA27976@hockin.org>
In-Reply-To: <20061027230458.GA27976@hockin.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610271804.52727.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wrong, too.  We have a patch that will be coming SOON (trust me, I am
> pushing hard for the author to publish it).  With this patch applied you
> should never see the TSC go backwards.  Period.  It should be monotonic
> (to userspace, kernel rdtsc calls can still be wrong).  CPUs should stay
> very nearly in sync (again, to userspace).  The Thoverhead of this patch is
> pretty minimal and costs nothing unless you actually read the TSC.

There is another patch in the pipeline to make gettimeofday use
RDTSC in more cases by keeping the offsets per CPU

(this has nothing to do with syncing TSCs which is not possible
in the general case on several platforms) 

I don't think it makes too much sense to hack on pure RDTSC when 
gtod is fast enough -- RDTSC will be always icky and hard to use.

-Andi

