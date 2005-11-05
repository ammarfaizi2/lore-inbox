Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVKEPhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVKEPhv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVKEPhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:37:51 -0500
Received: from defout.telus.net ([199.185.220.240]:11215 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S932082AbVKEPhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:37:50 -0500
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Subject: Re: disable tsc with seccomp
Date: Sat, 5 Nov 2005 16:37:44 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051105134727.GF18861@opteron.random>
In-Reply-To: <20051105134727.GF18861@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051637.44432.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 14:47, Andrea Arcangeli wrote:
> Hello,
>
> This changeset is backing out an useful feature I implemented some month
> ago:
>
>         http://kernel.org/hg/linux-2.6/?cs=2fd4e5f089df
>
> Anything that can strengthen security is needed, the covert channels are
> theoretically possible and this is a fact, you don't need hyperthreading
> for that.

It was useless, you can get exactly the same information by using RDPMC 
on perfctr 0 which always runs the NMI watchdog and counts all cycles too.

And even with that I don't want to have such checks in the context switch 
for something that is at best theoretical. Letting it in would open the 
floodgates for making the context switch really slow long term.

-Andi

