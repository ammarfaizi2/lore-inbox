Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSKTXHB>; Wed, 20 Nov 2002 18:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSKTXHB>; Wed, 20 Nov 2002 18:07:01 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:22029 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263188AbSKTXG7>; Wed, 20 Nov 2002 18:06:59 -0500
Date: Wed, 20 Nov 2002 23:14:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mark H. Wood" <mwood@IUPUI.Edu>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: One more time:  /usr/include/linux, /usr/include/asm
Message-ID: <20021120231403.A4533@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mark H. Wood" <mwood@IUPUI.Edu>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	libc-alpha@sources.redhat.com
References: <Pine.LNX.4.33.0211201643180.359-100000@mhw.ULib.IUPUI.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0211201643180.359-100000@mhw.ULib.IUPUI.Edu>; from mwood@IUPUI.Edu on Wed, Nov 20, 2002 at 05:05:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 05:05:45PM -0500, Mark H. Wood wrote:
> No dice.  glibc 2.3.1 still installs headers into /usr/include/{VARIOUS}
> which refer to /usr/include/linux and /usr/include/asm but does not supply
> that to which they refer.  *sigh*  After rummaging through several long
> threads in the archives, I still don't have an answer to the following:
> 
> 1. What is supposed to be in /usr/include/linux and /usr/include/asm?

There is no specification on what is supposed to be there.  For
compatiblity with programs written for old linux interfaces it is a good
idea to either place a copy of older kernel headers (2.2/2.4) or some
specific package to just provide those interfaces (like the redhat
glib-kernheaders rpm) there.

Note: glibc is one of the most-widely known packages that still
uses these obsolete interfaces

Note2: linux 2.5 headers slowly change to be no more compatible to those
interfaces, don't ever put copies of linux 2.5 headers there.

> 2. Where does the information come from?

It doesn't matter.

> 3. Who is responsible for putting it there?

The system integrator.

> I note that the glibc 2.3.1 instructions *still* instruct the reader to
> symlink these paths into "the 2.2 kernel sources".  (See "Specific advice
> for GNU/Linux systems" in INSTALL.)  I'll happily submit a glibc bug
> report, or documentation patches, or some such, just so long as someone
> can give me answers which work both for the kernel and for the library.

I've Cc'ed libc-alpha now because that's a glibc, not a kernel problem.
It's really a pity that glibc hasn't cought up _yet_.

