Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVGPQO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVGPQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGPQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:14:58 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:25261 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261233AbVGPQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:14:58 -0400
Message-ID: <42D932E2.20005@gentoo.org>
Date: Sat, 16 Jul 2005 17:16:34 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>, Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: Re: [PATCH] forcedeth: TX handler changes (experimental)
References: <42D9141E.3070401@colorfullife.com>
In-Reply-To: <42D9141E.3070401@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Manfred Spraul wrote:
> Attached is a patch that modifies the tx interrupt handling of the 
> nForce nic. It's part of the attempts to figure out what causes the nic 
> hangs (see bug 4552).
> The change is experimental: It affects all nForce versions. I've tested 
> it on my nForce 250-Gb.

This patch doesn't apply to 2.6.13-rc3:

patching file drivers/net/forcedeth.c
Hunk #1 FAILED at 87.
Hunk #2 FAILED at 100.
Hunk #3 FAILED at 135.
Hunk #4 succeeded at 145 (offset -3 lines).
Hunk #5 succeeded at 295 (offset -3 lines).
Hunk #6 succeeded at 305 (offset -3 lines).
Hunk #7 succeeded at 995 (offset -20 lines).
Hunk #8 succeeded at 1502 (offset -87 lines).
Hunk #9 succeeded at 2112 (offset -133 lines).
Hunk #10 FAILED at 2221.
4 out of 10 hunks FAILED -- saving rejects to file drivers/net/forcedeth.c.rej

I think this is because 2.6.13-rc3 has forcedeth 0.35.

I can't find the patch for 0.35 --> 0.36. (Is this when the netdev archives 
were in limbo?)

I found the patch for 0.36 --> 0.37 here : 
http://marc.theaimsgroup.com/?l=linux-netdev&m=112101962422678&w=2

Are the earlier changes a prerequisite, or can I just fix the TX handler 
rejects manually?

Thanks,
Daniel
