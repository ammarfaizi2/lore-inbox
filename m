Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVHUJuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVHUJuo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVHUJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:50:43 -0400
Received: from siaag2ah.compuserve.com ([149.174.40.141]:28511 "EHLO
	siaag2ah.compuserve.com") by vger.kernel.org with ESMTP
	id S1750917AbVHUJun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:50:43 -0400
Date: Sun, 21 Aug 2005 05:47:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] i386: semaphore ownership tracking
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200508210550_MC3-1-A7CF-D29F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2005 15:01:27 -0400, Lee Revell wrote:

> How is it different from the ownership tracking used for PI in the -rt
> kernel?

 Those are a completely new type of mutex (rt_mutex.)  Mine is a very
low-overhead (3 extra instructions in down()) addition to the normal
Linux semaphores.  I guess they are called compat_semaphores in -rt,
and I didn't see any ownership tracking for them in the -rt patch.

__
Chuck
