Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbVHXTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbVHXTzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVHXTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:55:21 -0400
Received: from math.ut.ee ([193.40.36.2]:12447 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751502AbVHXTzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:55:21 -0400
Date: Wed, 24 Aug 2005 22:55:04 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6: halt instead of reboot
In-Reply-To: <m1mznativw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
 <m14q9iva4q.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
 <m1mznativw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It does not hang, it just powers off like on halt.
>
> Ok. Then at least in part the kernel behavior is either
> intersecting with a BIOS bug, a bad reboot script that calls halt instead,
> or a driver that is scribbling on the wrong register.  There is
> nothing in that code path that should remove the power.

With reboot=c, reboot=w and reboot=h it still powers off. With reboot=b 
it actually reboots. With 2.6.13-rc2 (the previous good kernel here) it 
just works and does a reboot with no special parameters.

I also have lapic nmi_watchdog=1 in boot command line but removing these 
does not help either.

So far I only know that rc6+somegit and rc7 power off and rc2 works, 
will try som kernels inbetween.

-- 
Meelis Roos (mroos@linux.ee)
