Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbTIKEz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbTIKEz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:55:29 -0400
Received: from amdext2.amd.com ([163.181.251.1]:40695 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S266083AbTIKEzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:55:23 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B197@txexmtae.amd.com>
From: richard.brunner@amd.com
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Wed, 10 Sep 2003 23:55:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137EDFA41955605-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun,

I have to agree with what Andi says. It is in a slow path,
and we want to guard against user programs that could hit it.
Making it conditional doesn't buy a lot and would cause lots of
re-validation of the patch that we would like
to avoid so we can get this in to the 2.6 kernel ASAP. 
Don't worry! I am pretty certain the patch won't impact the 
performance of the 2.6 kernel on processors from other vendors ;-)

                       Thanks!
                                          ]-Rich ...
                                          ]AMD Fellow
> From: Nakajima, Jun [mailto:jun.nakajima@intel.com] 
>
> > I would hate to break this again just to save a few hundred bytes in 
> > this function. Also the overhead is very low so it is also not 
> > interesting to make it conditional for speed reasons.
> 
> For maintenance and testing purposes, I think it's still 
> better to make it conditional. If the errata are fixed, you 
> might want to kill the condition depending on the stepping, 
> for example. During the transition time, you need to support 
> both the steppings until old ones go away (then remove the 
> workaround).
> 
> Thanks,
> Jun

