Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVJKBUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVJKBUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJKBUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:20:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751336AbVJKBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:20:17 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Tue, 11 Oct 2005 03:20:27 +0200
User-Agent: KMail/1.8.2
Cc: Andrey Savochkin <saw@sawoct.com>, torvalds@osdl.org, dev@sw.ru,
       linux-kernel@vger.kernel.org, xemul@sw.ru, st@sw.ru, discuss@x86-64.org
References: <434520FF.8050100@sw.ru> <20051006192106.A13978@castle.nmd.msu.ru> <20051010175920.21018fac.akpm@osdl.org>
In-Reply-To: <20051010175920.21018fac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510110320.28302.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 October 2005 02:59, Andrew Morton wrote:

> >  I'm not advocating for changing spinlock implementation, it's just a
> >  thought...
>
> It would make sense in these cases if there was some primitive which we
> could call which says "hey, I expect+want another CPU to grab this lock in
> preference to this CPU".

I just don't know how to implement such a primitive given the guarantees
of the x86 architecture. It might be possible to do something that
works on specific CPUs, but that will likely break later.


-Andi
