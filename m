Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTEOUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTEOUF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:05:28 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:41921 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S264207AbTEOUFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:05:04 -0400
Subject: Re: 2.6 must-fix list, v2
From: Robert Love <rml@tech9.net>
To: shaheed <srhaque@iee.org>
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200305152107.17419.srhaque@iee.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1052990397.3ec35bbd5e008@netmail.pipex.net> <1053012743.899.5.camel@icbm>
	 <200305152107.17419.srhaque@iee.org>
Content-Type: text/plain
Message-Id: <1053030010.899.24.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 15 May 2003 16:20:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 16:07, shaheed wrote:

> I have no idea with whom to persue this path, and as I say, I feel that 
> solving this once for each distro is crazy IMHO.

It does not have to be done for each distribution. Modify the SysVinit
package directly to support this feature. All init needs to do is bind
itself to the allowed processors prior to its first fork(). This can be
done as part of the core init package, and thus all distributions
automatically reap the benefits.

If init is not modified, then it can be done in rc.d or wherever by
hand.

> I'm sorry to appear foolish, but as explained above, I genuinely don't 
> understand why this does not belong in the kernel. I would be grateful for 
> elaboration. If I really am being thick, then just ignore me and I'll just 
> solve this for myself using route 4.

Things which can be done in user-space should be done in user-space.
There is absolutely zero reason to do this in the kernel.  init can do
it.

Submit a patch to the init maintainer to have it bind itself on boot to
a given command line value. Maybe I will do this if I find the time...

	Robert Love

