Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTJPVab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTJPVab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:30:31 -0400
Received: from waste.org ([209.173.204.2]:51385 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263215AbTJPVaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:30:30 -0400
Date: Thu, 16 Oct 2003 16:30:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Eli Billauer <eli_billauer@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org,
       David Mosberger-Tang <David.Mosberger@acm.org>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016213023.GU5725@waste.org>
References: <HbGf.8rL.1@gated-at.bofh.it> <HbQ5.ep.27@gated-at.bofh.it> <Hdyv.2Vd.13@gated-at.bofh.it> <HeE6.4Cc.1@gated-at.bofh.it> <HjaT.3nN.7@gated-at.bofh.it> <Hjkw.3Al.11@gated-at.bofh.it> <ugzng1axel.fsf@panda.mostang.com> <3F8EF17A.2040502@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8EF17A.2040502@users.sf.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 09:28:58PM +0200, Eli Billauer wrote:
> Allow me to supply a couple facts about frandom:
> 
> * It's not a "crappy" RNG. Its RC4 origins and the fact, that it has 
> passed tests indicate the opposite. A fast RNG doesn't necessarily mean 
> a bad one. I doubt if any test will tell the difference between frandom 
> and any other good RNG. You're most welcome to try.
> 
> * Frandom is written completely in C. On an i686, gcc compiles the 
> critical part to 26 assembly instructions per byte, and I doubt if any 
> hand assembly would help significantly. The algorithms is clean and 
> simple, and the compiler performs well with it.

The output hash for /dev/random would use RC4 or the like except for
historical political reasons. I'm hoping to move it in that direction,
but adding yet another cryptographic algorithm outside cryptoapi is
a step in the wrong direction right now.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
