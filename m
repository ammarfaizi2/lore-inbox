Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTIAKLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTIAKLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:11:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57490 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262803AbTIAKLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:11:44 -0400
Date: Mon, 1 Sep 2003 03:02:36 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-Id: <20030901030236.654d0663.davem@redhat.com>
In-Reply-To: <20030901100458.GA1903@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829154101.GB16319@work.bitmover.com>
	<20030829230521.GD3846@matchmail.com>
	<20030830221032.1edf71d0.davem@redhat.com>
	<20030831224937.GA29239@mail.jlokier.co.uk>
	<20030831223102.3affcb34.davem@redhat.com>
	<20030901064231.GJ748@mail.jlokier.co.uk>
	<20030901000615.28d93760.davem@redhat.com>
	<20030901082911.GA1638@mail.jlokier.co.uk>
	<20030901020203.1779efe8.davem@redhat.com>
	<20030901100458.GA1903@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 11:04:58 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Of course if you make mmap() return EINVAL then it cannot possible fail :)

Right :-)

> > I'd suggest instead to hardcode the SHMLBA stuff into your sources.
> 
> How?  SHMLBA is a run time value on the Sparc; I have no idea how
> to work it out.

You're talking about 32-bit sparc, on sparc64 it's a constant
16K.

For sparc 32-bit, just use 4MB, that's the largest possible value.

And you have to check this with uname() results, not with ifdefs
as 32-bit Sparc binaries run on sparc64 systems just fine.

I also would not object at all to a kernel patch that exported the
SHMLBA value via some sysctl value.
