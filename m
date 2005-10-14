Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVJNShQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVJNShQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVJNShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750846AbVJNShO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:37:14 -0400
Date: Fri, 14 Oct 2005 11:37:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
In-Reply-To: <Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0510141136291.23590@g5.osdl.org>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
 <Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Oct 2005, linux-os (Dick Johnson) wrote:
> 
> Somehow, these spin-locks got all screwed up.

Nope.

> Given: nobody has the lock. The lock variable is 0.

Your "given" is wrong.

UNLOCKED is 1, locked is 0 or negative.

		Linus
