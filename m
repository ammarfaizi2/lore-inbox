Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbULEDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbULEDwD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 22:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbULEDwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 22:52:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261245AbULEDwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 22:52:01 -0500
Date: Sat, 4 Dec 2004 19:51:43 -0800
Message-Id: <200412050351.iB53phqK025663@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
X-Fcc: ~/Mail/linus
Cc: Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: Proposal for a userspace "architecture portability" library
In-Reply-To: Paul Mackerras's message of  Sunday, 5 December 2004 12:47:05 +1100 <16818.26777.209451.685576@cargo.ozlabs.ibm.com>
X-Windows: simplicity made complex.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think glibc exports any atomic operations.

That is true.  But it does have implementations in bits/atomic.h for many
processors, and that is under the LGPL.

> As for the semaphores and spinlocks, clearly you can use the pthread_*
> functions, but hopefully the kernel versions are a bit lighter-weight.

The pthread_spin_* functions are not inlines, but are otherwise minimal.
