Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUDTAbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUDTAbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUDTAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:31:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:15526 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261862AbUDTAbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:31:18 -0400
Subject: Re: siginfo & 32 bits compat, what is the story ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: joe.korty@ccur.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3vfjvtwor.fsf@averell.firstfloor.org>
References: <1MBxZ-6l5-37@gated-at.bofh.it> <1MLe2-5WC-25@gated-at.bofh.it>
	 <1MP7P-UD-13@gated-at.bofh.it>  <m3vfjvtwor.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1082421048.1677.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 10:30:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that there are several kinds of x86-64 codes: the original one
> and Joe's rewritten version in recent kernels. I don't know where
> you heard it is broken, but maybe they were describing the older
> code.

Discussing with Stephen, looking at the current code.

> If they were refering to the recent version I assume they 
> would have reported it to the maintainer. But they didn't ...
> 
> Anyways - i guess it's hard to make such a decision on hearsay.  I
> would suggest you start with the x86-64 version and when there are
> really problems you tell us about them and we fix them.
> 
> BTW there was a merged version from some PA-RISC person (with yet
> another rewritten siginfo copy function) discussed, but for some
> reason he dropped the ball. 

So I suppose the decision to actually copy _and_ convert those 3 fields
when moving a userland siginfo around is based on an analysis of what
userland usually does ? What bothers me is that any app that uses a
different siginfo layout will be broken between 32 bits and 32 bits
with this scheme, but maybe that just never happens ?

Ben.


