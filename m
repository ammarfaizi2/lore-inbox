Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUDSWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUDSWod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUDSWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:44:33 -0400
Received: from zero.aec.at ([193.170.194.10]:28939 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261793AbUDSWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:44:23 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: siginfo & 32 bits compat, what is the story ?
References: <1MBxZ-6l5-37@gated-at.bofh.it> <1MLe2-5WC-25@gated-at.bofh.it>
	<1MP7P-UD-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 20 Apr 2004 00:44:20 +0200
In-Reply-To: <1MP7P-UD-13@gated-at.bofh.it> (Benjamin Herrenschmidt's
 message of "Tue, 20 Apr 2004 00:10:09 +0200")
Message-ID: <m3vfjvtwor.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> I believe the x86_64 method is correct.
>> 
>> It might be worth moving this compatibility code to a
>> common place where all architectures could reference it.
>
> Hrm... I just heard the opposite: that is, the x86_64 code allows
> some cruft to communicate between 32 and 64 bits, but breaks anything
> that uses more than those 3 copied fields, even between 2 32 bits
> applications.

Note that there are several kinds of x86-64 codes: the original one
and Joe's rewritten version in recent kernels. I don't know where
you heard it is broken, but maybe they were describing the older
code.

If they were refering to the recent version I assume they 
would have reported it to the maintainer. But they didn't ...

Anyways - i guess it's hard to make such a decision on hearsay.  I
would suggest you start with the x86-64 version and when there are
really problems you tell us about them and we fix them.

BTW there was a merged version from some PA-RISC person (with yet
another rewritten siginfo copy function) discussed, but for some
reason he dropped the ball. 

-Andi

