Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285440AbRLYKBg>; Tue, 25 Dec 2001 05:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285448AbRLYKB0>; Tue, 25 Dec 2001 05:01:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285440AbRLYKBK>; Tue, 25 Dec 2001 05:01:10 -0500
Date: Tue, 25 Dec 2001 10:00:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Doug Ledford <dledford@redhat.com>,
        David Lang <david.lang@digitalinsight.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
Message-ID: <20011225100059.A7424@flint.arm.linux.org.uk>
In-Reply-To: <3C277049.3070000@redhat.com> <31754.1009246706@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31754.1009246706@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Dec 25, 2001 at 01:18:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2001 at 01:18:26PM +1100, Keith Owens wrote:
> i386 dynamic syscall table starts at 240.  Last assigned syscall entry
> is currently 225, leaving room for 14 new assigned syscalls.  2.4.0
> (January 5 2001) had 222 syscalls, so 2.4 added 3 assigned syscalls in
> just under a year.

Erm, there's a rather obvious flaw in your argument here - 2.4 is supposed
to be a stable kernel with relatively few features appearing in it.  We're
now into 2.5.  We've already seen several people trying to get new syscall
numbers between 2.5.0 and 2.5.1, which is also a relatively short
timeframe.

Lets look at some more realistic timeframe.  These figures are for i386:

	2.2.20	- 190 syscalls, last one is sys_vfork
	2.4.17	- 225 syscalls, last one is sys_readahead

So, between these two stable kernel series, _35_ syscalls have been added.
If we assume this trend will continue through 2.5, then we'll be up to
260 syscalls when 2.6 or 3.0 is out.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

