Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUBQOZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUBQOZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:25:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:59873 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266176AbUBQOZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:25:23 -0500
Subject: Re: UTF-8 and case-insensitivity
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: tridge@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16433.38038.881005.468116@samba.org>
References: <16433.38038.881005.468116@samba.org>
Content-Type: text/plain
Message-Id: <1077027916.4532.32.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 08:25:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 22:12, tridge@samba.org wrote:
> Given how much pain the "kernel is agnostic to charset encoding"
> attitude has cost me in terms of programming pain, I thought I should
> de-cloak from lurk mode and put my 2c into the UTF-8 issue.
> 
> Personally I think that eventually the Linux kernel will have to
> embrace the interpretation of the byte streams that applications have
> given it, despite the fact that this will be very painful and
> potentially quite complex. The reason is that I think that eventually
> the Linux kernel will need to efficiently support a userspace policy
> of case-insensitivity and the only way to do case-insensitive filename
> operations is to interpret those byte streams as a particular
> encoding.
> 
> Personally I much prefer the systems I use to be case-sensitive, but
> there are important applications that require case-insensitivity for
> interoperability. Right now it is not possible to write a case
> insensitive application on Linux in an efficient manner. With the
> current "encoding agnostic" APIs a simple open() or stat() call
> becomes a horrendously expensive operation and one that is fraught
> with race conditions. Providing the same functionality in the kernel
> is dirt cheap by comparison (not cheap in terms of code complexity,
> but cheap in terms of runtime efficiency).

This would be easy to do in JFS due to the baggage we carried over to be
compatible with OS/2-formatted volumes.  In OS/2, the directories were
ordered in a case-insensitive fashion.  This would have to be a mkfs
option, and would not be a per-process option.  The directories must be
created either case-sensitive or not.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

