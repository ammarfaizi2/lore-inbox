Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751974AbWJ3Ub2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWJ3Ub2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWJ3Ub1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:31:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41419 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751974AbWJ3Ub1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:31:27 -0500
Date: Mon, 30 Oct 2006 12:30:58 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: thockin@hockin.org
cc: Luca Tettamanti <kronos.it@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
In-Reply-To: <20061027230458.GA27976@hockin.org>
Message-ID: <Pine.LNX.4.64.0610301228180.21619@schroedinger.engr.sgi.com>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan>
 <20061027230458.GA27976@hockin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, thockin@hockin.org wrote:

> Wrong, too.  We have a patch that will be coming SOON (trust me, I am
> pushing hard for the author to publish it).  With this patch applied you
> should never see the TSC go backwards.  Period.  It should be monotonic
> (to userspace, kernel rdtsc calls can still be wrong).  CPUs should stay
> very nearly in sync (again, to userspace).  The overhead of this patch is
> pretty minimal and costs nothing unless you actually read the TSC.

Well why not use regular clock_gettime() instead? If you add code for TSC 
processing (intercepting RDTSC from user space???)  then it may be 
comparable in performance to time retrieval via POSIX calls using 
vsyscalls. Look like you may start duplicating the time subsystem?


