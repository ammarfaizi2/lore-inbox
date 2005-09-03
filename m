Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVICRkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVICRkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVICRkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:40:35 -0400
Received: from mailfe14.swip.net ([212.247.155.161]:29613 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751252AbVICRkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:40:35 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sat, 3 Sep 2005 19:40:31 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Johnny Stenback <jst@jstenback.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc coredump with 2.6.12+ kernels
Message-ID: <20050903174030.GA5406@localhost.localdomain>
References: <4319DC91.4020406@jstenback.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4319DC91.4020406@jstenback.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 10:25:37AM -0700 Johnny Stenback wrote:

> Hey all,
> 
> I just attempted to upgrade my kernel to 2.6.13. The kernel appears to 
> boot and run just fine, but when I try to build any larger projects like 
> Mozilla or the Linux kernel I constantly get segfaults from gcc. All 
> other apps *seem* to work fine. I remember seeing this with 2.6.12 too 
> when I tried to upgrade to it too but I didn't have the time to 
> investigate at all then, but now I see the same problem with 2.6.13. The 
> last version I've used that didn't show this problem is 2.6.11.3, and 
> that's running with no problems here.
> 
> When gcc segfaults I get the following messages in the messages log:
> 
> cc1[16775]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
> 00007fffffaaf0a0 error 4
> cc1[17086]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
> 00007fffffc4dfc0 error 4
> cc1[17788]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
> 00007fffffd777e0 error 4
> cc1[17823]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
> 00007fffffc4d630 error 4
> cc1[17895]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
> 00007ffffffd2330 error 4
> 
> I'm on a dual AMD Opteron system, running x86_64 code. Using Fedora Core 
> 2 (yeah, old, I know...) and gcc 3.3.3 20040412.

Does it still happen if you run:

echo 0 > /proc/sys/kernel/randomize_va_space
