Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbULYL1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbULYL1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULYL1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:27:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8601 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261498AbULYL1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:27:40 -0500
Date: Sat, 25 Dec 2004 12:27:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
In-Reply-To: <200412251101.iBPB1IpP009024@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.61.0412251226200.25122@yvahk01.tjqt.qr>
References: <200412251101.iBPB1IpP009024@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
>>>> 
>>> But, does unit-at-a-time work reliably for all compilers on all archs back 
>>> to and including gcc 2.95.3 ? 
>>
>>Unit-at-a-time is only available in GCC 3.4 and above.

No, it's already in my 3.3.0 (SUSE Linux 8.2) and continues to exist in 3.3.3 
(9.2)

>The problem with unit-at-a-time isn't compiler availability,
>but the fact that at least with gcc-3.4 on x86 it causes
>significant stack usage increases, which in the kernel lead
>to stack overflow problems. This is not a theoretical issue,
>the overflows have been observed in normal kernels.
>
>So wrt inlining failures, the correct fix is to remove the
>inlines or rearrange the code to allow inlining w/o unit-at-a-time.

Or making some pressure on gcc developers to fix the increase.



Jan Engelhardt
-- 
ENOSPC
