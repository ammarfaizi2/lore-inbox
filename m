Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTILR1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTILR1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:27:37 -0400
Received: from [213.13.155.14] ([213.13.155.14]:30471 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261788AbTILR1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:27:35 -0400
Subject: Re: nasm over gas?
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: insecure@mail.od.ua
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309121826.22936.insecure@mail.od.ua>
References: <20030904104245.GA1823@leto2.endorphin.org>
	 <200309100034.58742.insecure@mail.od.ua>
	 <pan.2003.09.11.11.06.59.523742@zmail.pt>
	 <200309121826.22936.insecure@mail.od.ua>
Content-Type: text/plain
Message-Id: <1063387648.15891.26.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Sep 2003 18:27:29 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Fri, 12 Sep 2003 18:24:50 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 16:26, insecure wrote:

> > You're quite right, but the I-Cache is a non issue: this code will be
> Please disable icache on your CPU ;)
[snip]
> How can you know that it won't evict useful code?

a) the code is at the beginning of the program
b) its only run once

Therefore, its impact on i-cache is a non-issue. I wasn't disscussing
the merits of a i-cache.

> > You can complain about the time it gets to fetch the code from
> > RAM though.
> 
> Thanks for the tip. I missed that!

Welcome.

> It makes perfectly fine point that gcc code is not good.
> It just wasted 8 bytes in a rather simple code sequence.

First of all, it would have been nice to see the relevant code and
optimization flags.

I'll assume the goal is speed, not code size. Lets look at that piece of
code:
a) its only run once, so it doesn't benefict of caching
b) there are no loads there, so it can't be prefetched while the CPU
waits for loads
And thats what makes its performance benefict of smaller code size.
But its also irrelevant to global performance. And I can't even imagin
any code that meets a) and b) and is relevant for performance.
In modern, general purpose, computer systems, code size is irrelevant.
It has been for 15 years and its not going to change.
And I'm not going to complaint about the compiler making a bad decision
on such a irrelevant case and one that is not worth re-writing in
assembly.

-- 
	Ricardo

