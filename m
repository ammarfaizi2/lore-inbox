Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTICSH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTICSG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:06:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264115AbTICSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:05:27 -0400
Date: Wed, 3 Sep 2003 19:05:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030903190519.D24951@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Larry McVoy <lm@work.bitmover.com>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk> <20030902195222.D9345@flint.arm.linux.org.uk> <20030902235900.GA5769@work.bitmover.com> <20030903083118.A17670@flint.arm.linux.org.uk> <20030903074134.GB19920@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030903074134.GB19920@mail.jlokier.co.uk>; from jamie@shareable.org on Wed, Sep 03, 2003 at 08:41:34AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:41:34AM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > > > Multiple mappings of the same object rarely occur in my experience, so
> > > > the resulting performance loss caused by working around the cache and
> > > > writebuffer is something we can live with.
> > > 
> > > Multiple *writable* mappings.   Don't forget about libc et al.
> > 
> > I mean in the same group of threads with the same struct mm, not the whole
> > system.
> 
> Larry means that it's perfectly normal for libc to map the same file
> more than once: you have the code section and the data section.

Code is read-only, data is read-write and is copy on write.  Therefore
its a different scenario.

Practical tests indicate that the vast majority of applications do not
trip the test.

You're right in theory, but I don't particularly care about theory when
its real life which matters.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

