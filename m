Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274046AbRISNLE>; Wed, 19 Sep 2001 09:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274047AbRISNKy>; Wed, 19 Sep 2001 09:10:54 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:55794 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S274046AbRISNKm>;
	Wed, 19 Sep 2001 09:10:42 -0400
Posted-Date: Wed, 19 Sep 2001 15:10:56 +0200
Date: Wed, 19 Sep 2001 15:10:56 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: diffserv-general@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Can two eths run concurent dequeues in 2.4 ?
In-Reply-To: <002301c1406a$0f92bb30$5f01a8c0@worm>
Message-ID: <Pine.LNX.4.10.10109191504170.19206-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.2 the qdisc dequeues are called from BHs and there are 
guaranted that only one BH runs at any time on given
set of CPUs.

In 2.4 timer and dequeues are called AFAIK from softirqs.
Softirqs can run concurently on several CPUs.

So I wonder if dequeue routine of one qdisc can
be called in the same time as dequeue on another
qdisc is running (on another CPU).
And whether timer callback can be called during
dequeue execution (it can't on 2.2).

Thanks, devik



