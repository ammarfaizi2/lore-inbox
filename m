Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWGOVr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWGOVr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWGOVr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 17:47:27 -0400
Received: from canuck.infradead.org ([205.233.218.70]:421 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161048AbWGOVr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 17:47:26 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 22:47:00 +0100
Message-Id: <1153000020.8427.16.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 17:09 -0400, Albert Cahalan wrote:
> David Woodhouse writes:
> > Kernel headers are _not_ a library of random crap for userspace to 
> > use.

> Don't blame app developers if they go for what is good.
> To stop them, provide the goodness in a sane way.
> (alternately, make the Linux code suck ass more than POSIX) 

Kernel headers are _not_ a library of random crap for userspace to use.

There is no justification for asm/atomic.h being installed
in /usr/include. Especially since, as Arjan points out, it doesn't
actually provide atomic operations in many cases anyway.

However, the kernel is released under a licence which allows you to
re-use code from it if you really want. If you want to provide a
'libkernelstuff', the GPL permits you to do that. The kernel's ABI
headers (and lkml) are not the appropriate place for such a project
though. If you want to do that, take it where the C++ and microkernel
people go.

Btw, your mail client omitted the References: and In-Reply-To: headers
which RFC2822 says it SHOULD have included. On a list with as much
traffic as linux-kernel, that's _very_ suboptimal, because you've
detached your message from the thread to which you replied. Please try
to fix or work around that.

-- 
dwmw2

