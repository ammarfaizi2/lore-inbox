Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVJFOxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVJFOxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVJFOxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:53:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751056AbVJFOxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:53:11 -0400
Date: Thu, 6 Oct 2005 07:52:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrey Savochkin <saw@sawoct.com>
cc: Andi Kleen <ak@suse.de>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
In-Reply-To: <20051006174604.B10342@castle.nmd.msu.ru>
Message-ID: <Pine.LNX.4.64.0510060750230.31407@g5.osdl.org>
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de>
 <20051006174604.B10342@castle.nmd.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Andrey Savochkin wrote:
> 
> Well, it's hard to swallow...
> It's not about being not fully fair, it's about deadlocks that started
> to appear after code changes inside retry loops...

No, it's not about fairness.

It's about BUGS IN YOUR CODE.

If you need fairness, you need to implement that yourself. You can do so 
many ways. Either on top of spinlocks, by using an external side-band 
channel, or by using semaphores instead of spinlocks (semaphores are much 
higher cost, but part of the cost is that they _are_ fair).

		Linus
