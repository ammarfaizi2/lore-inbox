Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTIBSwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTIBSwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:52:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58126 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261317AbTIBSwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:52:34 -0400
Date: Tue, 2 Sep 2003 19:52:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902195222.D9345@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902115731.GA14354@mail.jlokier.co.uk>; from jamie@shareable.org on Tue, Sep 02, 2003 at 12:57:31PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:57:31PM +0100, Jamie Lokier wrote:
> You say that "reading from the first mapping _should_ return the
> second write value no matter what", but that there's a bug in the
> write buffer and it isn't doing that.
> 
> I'm saying that the bug can't be that, because such a bug would affect
> normal applications.

I know of no other explaination which fits with the information I have
available to me here.  If you'd care to speculate further, you may,
but I see further speculation as being rather academic, unless it comes
from one of the people who designed the chip.

All this is, however, immateral - the facts are that the write buffer
is buggy, this test detects it, and we can take fairly easy measures
to ensure we fix it up.

Multiple mappings of the same object rarely occur in my experience, so
the resulting performance loss caused by working around the cache and
writebuffer is something we can live with.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

