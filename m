Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUIVW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUIVW1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIVW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:27:12 -0400
Received: from zero.aec.at ([193.170.194.10]:9991 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268005AbUIVW1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:27:11 -0400
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: year 2038 problem on x86-64
References: <2Hn0k-2wz-9@gated-at.bofh.it> <2HnjK-2Ha-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 23 Sep 2004 00:27:08 +0200
In-Reply-To: <2HnjK-2Ha-3@gated-at.bofh.it> (Pavel Machek's message of "Thu,
 23 Sep 2004 00:00:12 +0200")
Message-ID: <m33c1a9byb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:
>
> ... __ARCH_WANT_SYS_TIME actually is set on x86-64.

But it's not used. It declares an own sys_time64 in arch/x86_64
By default the vsyscall code is used.

Also sys_time is legacy, most users should be using gettimeofday()

-Andi

