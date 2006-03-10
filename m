Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWCJAy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWCJAy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWCJAy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:54:27 -0500
Received: from ozlabs.org ([203.10.76.45]:57835 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932140AbWCJAyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:54:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17424.52795.142571.746064@cargo.ozlabs.ibm.com>
Date: Fri, 10 Mar 2006 11:54:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
In-Reply-To: <20060310004815.GD24904@devserv.devel.redhat.com>
References: <16835.1141936162@warthog.cambridge.redhat.com>
	<17424.48029.481013.502855@cargo.ozlabs.ibm.com>
	<20060310004815.GD24904@devserv.devel.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> On Fri, Mar 10, 2006 at 10:34:53AM +1100, Paul Mackerras wrote:
> > MMIO accesses are done under a spinlock, and that if your driver is
> > missing them then that is a bug.  I don't think it makes sense to say
> > that mmiowb is required "on some systems".
> 
> Agreed. But if it is missing it may not be a bug. It depends what the lock
> actually protects.

True.  What I want is a statement that if one of the purposes of the
spinlock is to provide ordering of the MMIO accesses, then leaving out
the mmiowb is a bug.  I want it to be like the PCI DMA API in that
drivers are required to use it even on platforms where it's a no-op.

Paul.

