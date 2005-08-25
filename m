Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVHYQyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVHYQyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHYQyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:54:22 -0400
Received: from ns1.suse.de ([195.135.220.2]:58016 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751163AbVHYQyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:54:21 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] x86_64 Avoid some atomic operations during address space destruction
Date: Thu, 25 Aug 2005 18:54:09 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pratap Subrahmanyam <pratap@vmware.com>
References: <42F5FB9A.5000708@vmware.com>
In-Reply-To: <42F5FB9A.5000708@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251854.10060.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 August 2005 14:16, Zachary Amsden wrote:
> This turned out to be a huge win on 32-bit i386 in PAE mode, but it is
> likely not as significant on x86_64; I don't know because I haven't
> actually measured the cost.  I don't have 64-bit hardware that I have
> the luxury of rebooting right now, so this patch is untested, but if
> someone wants to try this out, it might actually show a measurable win
> on fork/exit.  I lost my cycle count measurement diffs, but I don't
> think they would apply cleanly to x86_64 anyways.  This patch at least
> looks good, and compiles cleanly on 2.6.13-rc5-mm1, thus passing some
> level of testing.

FYI I have queued it, but cannot apply it because the necessary generic
code support is still not in mainline.

Do you have any other optimizations pending for x86-64? 

There is still the iopl optimization that you did that is on my TODO list to 
add. Anything else.

-Andi
