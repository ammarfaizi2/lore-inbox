Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVCXSw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVCXSw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCXSw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:52:58 -0500
Received: from one.firstfloor.org ([213.235.205.2]:12729 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262648AbVCXSvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:51:33 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	<20050323203856.17d650ec.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 24 Mar 2005 19:51:30 +0100
In-Reply-To: <20050323203856.17d650ec.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 23 Mar 2005 20:38:56 -0800")
Message-ID: <m1y8cc3mj1.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> David McCullough <davidm@snapgear.com> wrote:
>>
>> Here is a small patch for 2.6.11 that adds a routine:
>> 
>>  	add_true_randomness(__u32 *buf, int nwords);
>
> It neither applies correctly nor compiles in current kernels.  2.6.11 is
> very old in kernel time.
>
> Are we likely to see any in-kernel users of this?

I added similar support to the pre hw_random AMD8111 driver
a long time ago. Basically a timer that regularly read some
dat from the hw random generator and feed it into the random
code.

I think it is a good idea, because it doesnt make much sense
imho to run a daemon for something that can be done in 20 lines
of code in the kernel.

-Andi 
