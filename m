Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUCWMfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCWMfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:35:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:44030 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262528AbUCWMfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:35:12 -0500
Date: Tue, 23 Mar 2004 18:04:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: tiwai@suse.de, Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323123426.GG3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <20040323122925.GH22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323122925.GH22639@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 01:29:25PM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 23, 2004 at 03:47:55PM +0530, Dipankar Sarma wrote:
> > Here is the RCU patch for low scheduling latency Andrew was talking
> > about in the other thread. I had done some measurements with
> 
> I don't see why you're using an additional kernel thread. I told you one
> way to implement it via softirq taking advantage of the scheduler-friendy
> re-arming tasklets.

I have a patch for that too which I have been testing for DoS in
route cache, not latency. It is worth testing it here, however 
I think re-arming tasklets is not as friendly to latency as
executing the rcu callbacks from process context. One thing
I have noticed is that more softirqs worsen latency irrespective
of the worst-case softirq length.

Thanks
Dipankar
