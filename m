Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVF3Vqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVF3Vqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVF3Vqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:46:47 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6925 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263032AbVF3Vqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:46:45 -0400
Date: Thu, 30 Jun 2005 23:46:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: setitimer expire too early (Kernel 2.4)
Message-ID: <20050630214642.GK8907@alpha.home.local>
References: <42C444AA.2070508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C444AA.2070508@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Olivier,

On Thu, Jun 30, 2005 at 09:14:50PM +0200, Olivier Croquette wrote:
> 
> I am refering to this bug:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4569
> 
> A thread led to a patch from Paulo:
> 
> http://kerneltrap.org/mailarchive/1/message/59454/flat
> 
> This patch has been included in the kernel 2.6.12.
> 
> 1. How can I easily check if the patch is planned for include in the 2.4?

Right now, simply by asking Marcelo. As he's moving his tree from BK to
git, I suspect we'll not see any intermediate merge before 2.4.32-pre1.

> 2. I downloaded the full 2.4.31 source code. The patch appears not to be 
> included. Where/Who should I signal that?

Here is a good place. Unfortunately, the thread pointed above ended
quickly, and it does not seem clear from this whether Paulo's patch
should be applied or not, as adding 1 jiffie at 100 Hz will result in
a (noticeable) 10 ms additionnal sleep time. If you know of applications
which break because of this problem, and there is a general consensus
stating that the patch will not break anything, I can issue a 2.4.31-hf1,
but it does not seem critical enough to justify a hotfix.

Regards,
Willy

