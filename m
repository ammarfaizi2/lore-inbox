Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUEWM32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUEWM32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 08:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEWM32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 08:29:28 -0400
Received: from zero.aec.at ([193.170.194.10]:21765 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262648AbUEWM31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 08:29:27 -0400
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus sigaltstack calls by rt_sigreturn
References: <1YQB7-2XK-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 23 May 2004 14:29:24 +0200
In-Reply-To: <1YQB7-2XK-7@gated-at.bofh.it> (Roland McGrath's message of
 "Sun, 23 May 2004 04:10:06 +0200")
Message-ID: <m38yfjtjh7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> There is a longstanding bug in the rt_sigreturn system call.
> This exists in both 2.4 and 2.6, and for almost every platform.

I don't think the patch is really needed on x86-64 because the
kernel address should always return -EFAULT in access_ok().

Too bad, there are definitely some mysterious 32bit signal
failures left, e.g. newer valgrind still doesn't work reliable.

-Andi

