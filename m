Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSHEUIt>; Mon, 5 Aug 2002 16:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSHEUIt>; Mon, 5 Aug 2002 16:08:49 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:49807 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318858AbSHEUIs>; Mon, 5 Aug 2002 16:08:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating usermode linux]
Date: Mon, 5 Aug 2002 22:01:31 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <17boD0-1BMTyaC@fmrl08.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, people who play games with FP actually change the FP data on the
> stack frame, and depend on signal return to reload it. Admittedly I've
> only ever seen this on SIGFPE, but anyway - this is all done with integer
> instructions that just touch bitpatterns on the stack.. The kernel can't
> catch it sanely.

Could the fp state be put on its own page and the dirty bit
evaluated in the decision whether to restore fpu state ?

	Regards
		Oliver
