Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUIOPqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUIOPqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUIOPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:46:54 -0400
Received: from zero.aec.at ([193.170.194.10]:19462 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266513AbUIOPqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:46:49 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
References: <2EJTp-7bx-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 15 Sep 2004 17:46:46 +0200
In-Reply-To: <2EJTp-7bx-1@gated-at.bofh.it> (Ingo Molnar's message of "Wed,
 15 Sep 2004 17:30:07 +0200")
Message-ID: <m3vfefa61l.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> the attached patch is a new approach to get rid of Linux's Big Kernel
> Lock as we know it today.

Interesting approach. Did you measure what it does to context
switch rates? Usually adding semaphores tends to increase them
a lot.

One minor comment only: 
Please CSE "current" manually. It generates much better code
on some architectures because the compiler cannot do it for you.

-Andi

