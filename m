Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUCWM2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUCWM2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:28:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24002
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262518AbUCWM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:28:34 -0500
Date: Tue, 23 Mar 2004 13:29:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: tiwai@suse.de, Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323122925.GH22639@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323101755.GC3676@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 03:47:55PM +0530, Dipankar Sarma wrote:
> Here is the RCU patch for low scheduling latency Andrew was talking
> about in the other thread. I had done some measurements with

I don't see why you're using an additional kernel thread. I told you one
way to implement it via softirq taking advantage of the scheduler-friendy
re-arming tasklets.
