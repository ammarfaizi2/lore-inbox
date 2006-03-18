Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWCRUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWCRUaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWCRUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:30:10 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:55774
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750947AbWCRUaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:30:09 -0500
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
In-Reply-To: <9a8748490603181223i32391d96nf794e93aa734f785@mail.gmail.com>
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
	 <9a8748490603181223i32391d96nf794e93aa734f785@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 21:30:20 +0100
Message-Id: <1142713820.17279.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 21:23 +0100, Jesper Juhl wrote:

> Wouldn't this only break existing applications that do incorrect
> things (passing invalid values) ?
> If that's the case I'd say breaking them is OK and we should change to
> follow the spec.
> 
> I don't like potential userspace breakage any more than the next guy,
> but if the breakage only affects buggy applications then I think it's
> more acceptable.

Yes, it only breaks buggy applications.

On a full blown desktop the check (I added a printk) did not trigger.

The only application I found so far was the LTP setitimer "correctness"
test, which did not initialize it_interval and handed random garbage to
the kernel. :)

	tglx


