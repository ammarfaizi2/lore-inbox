Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbULEX3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbULEX3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULEX3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:29:52 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:54758 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261414AbULEX3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:29:49 -0500
Date: Sun, 5 Dec 2004 15:29:09 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: Proposal for a userspace "architecture portability" library
Message-ID: <20041205232909.GE26040@ca-server1.us.oracle.com>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	libc-alpha@sources.redhat.com
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 11:53:43AM +1100, Paul Mackerras wrote:
> Some of our kernel headers implement generally useful abstractions
> across all of the architectures we support.  I would like to make an
> "architecture portability" library, based on the kernel headers but as
> a separate project from the kernel, and intended for use in userspace.

	I'd love to see this also.  We've wrapped kernel-style bitops
from ext2 in
http://oss.oracle.com/projects/ocfs2-tools/src/trunk/libocfs2/include/bitops.h
(code is very similar to the libext2fs version).  We've also done the
kernel endian macros in userspace (glibc) in
http://oss.oracle.com/projects/ocfs2-tools/src/trunk/libocfs2/include/byteorder.h.
These might be useful (or not).  Also, I'd suggest list.h and
rbtree.[ch].  We use them extensively, as they are nice implementations
with little to no dependancies on anything else.
	Again, we've taken the approach of not including kernel headers,
instead making the kernel interface work via userspace methods.  I would
love to leave that work up to this library, and then just use it.

Joel

-- 

	Pitchers and catchers report.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
