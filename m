Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266162AbUAQT2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUAQT2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:28:41 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:53170 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266162AbUAQT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:28:28 -0500
Subject: Re: [RFC] kill sleep_on
From: David Woodhouse <dwmw2@infradead.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40098251.2040009@colorfullife.com>
References: <40098251.2040009@colorfullife.com>
Content-Type: text/plain
Message-Id: <1074367701.9965.2.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sat, 17 Jan 2004 19:28:21 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-17 at 19:43 +0100, Manfred Spraul wrote:
> Virtually all sleep_on / interruptible_sleep_on users are racy. Actually
> there is only one safe case: if both wakeup and sleep happen under
> lock_kernel.
> Any objections against killing it entirely? Or what about marking it as
> deprecated, as the first step towards killing it?
> 
> I'll follow with two patches that remove it from shaper and sunrpc/sched
> - shaper is racy, rpciod_down is only safe if called with lock_kernel.

Deprecate it in 2.7.0 and add BUG_ON(BKL not held) to it. Not before
time.

-- 
dwmw2


