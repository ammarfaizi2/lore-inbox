Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWE1V34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWE1V34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWE1V34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:29:56 -0400
Received: from proof.pobox.com ([207.106.133.28]:26041 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750950AbWE1V34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:29:56 -0400
Date: Sun, 28 May 2006 14:29:51 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
 Inspiron 6000
Message-Id: <20060528142951.2a7417cb.dickson@permanentmail.com>
In-Reply-To: <1148850683.3074.72.camel@laptopd505.fenrus.org>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<1148850683.3074.72.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 23:11:23 +0200, Arjan van de Ven wrote:

> On Sun, 2006-05-28 at 14:02 -0700, Paul Dickson wrote:
> > I follow the Fedora development kernels and noticed that resuming from
> > suspending (and hibernate) stopped working at 2.6.16-git15 (Fedora Core
> > kernel 2102).  Trouble was, my only previous kernel was 2.6.16-rc6-git12
> > (FC 2064) because I had been out of town for nearly two weeks (I did have
> > limited net access and that's how I got that last working version).
> 
> have you verified they have both the same general .config file? Like
> both are smp or both UP, same APIC settings etc etc 
> That's all easy to check and those two are the most likely candidates in
> config land that could break resume... 
> (not saying those are the cause or have changed, no idea, but they're
> really cheap to check that none have changed, much cheaper than a
> bisect ;)

Not the Fedora kernels, but the ones I'm bisecting have the same .config
(modulus "make oldconfig").  I did lose some time when somehow SMP got
enabled between the test of 2.6.16 and 2.6.17-rc1.  I ended up testing
2.6.17-rc1 without suspend being in the kernel (that kernel wouldn't
suspend).  After that, I have been verifying that each kernel will have
suspend compiled in before the hour long make session.

	-Paul

