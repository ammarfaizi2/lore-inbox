Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUHBXhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUHBXhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHBXgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:36:46 -0400
Received: from zero.aec.at ([193.170.194.10]:65036 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264297AbUHBXfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:35:48 -0400
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initial bits to help pull jiffies out of drivers
References: <2mGr0-7w6-27@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 03 Aug 2004 01:35:44 +0200
In-Reply-To: <2mGr0-7w6-27@gated-at.bofh.it> (Alan Cox's message of "Tue, 27
 Jul 2004 22:10:10 +0200")
Message-ID: <m37jshru3z.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> This is really for comment, the basic idea is to add some relative
> timer functionality. This gives us timeout objects as well as pulling
> jiffies use into one place in the timer code. The need for the old
> interfaces never goes away however because some code uses a previous
> event base to construct timeouts to avoid sliding due to the latency
> between service and re-addition.

I don't think it matters much for the specific goal of getting rid
of regular timer ticks. I expect even a jiffies less kernel to
emulate jiffies using CLOCK_MONOTONIC and some timer for quite some
time. Basically on these kernels it will just be a bit more expensive
too use, but not much.

Of course add_timeout makes a nicer API in general, so it may be 
still a good idea.

-Andi

