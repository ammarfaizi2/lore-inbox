Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTLOKSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLOKSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:18:03 -0500
Received: from zero.aec.at ([193.170.194.10]:26631 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263453AbTLOKSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:18:00 -0500
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Mon, 15 Dec 2003 11:17:35 +0100
In-Reply-To: <12XQ2-7Vs-9@gated-at.bofh.it> (Vladimir Kondratiev's message
 of "Mon, 15 Dec 2003 11:10:14 +0100")
Message-ID: <m3llpepeps.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <12KJ6-4F2-13@gated-at.bofh.it> <12Lvu-5X5-5@gated-at.bofh.it>
	<12XQ2-7Vs-9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>
> As I explained in comment to function, it is not really critical. The
> problem is, there is no generic way (or I don't know it) to recognize
> PCI-E. One suggest to go over all devices and see whether PCI-E
> capability present for at least one of them. I don't think it is good
> way to do. Sanity check do pretty good job here. If it is not PCI-E
> platform, this address in physical memory will not be connected to
> anything real. You will get 0xff's.

I don't think that's a good assumption. There will be surely be some 
machine that has an mapping there. You will need to find some fool
proof way to detect the presence of PCI-Express. Otherwise it will likely
fail the number one criterium for merging ("it shall not break 
anything else")

And in general new development should be done in 2.6 first...

-Andi
