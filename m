Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWHXUFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWHXUFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWHXUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:05:24 -0400
Received: from pat.uio.no ([129.240.10.4]:8653 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030470AbWHXUFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:05:23 -0400
Subject: Re: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR
	decode
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, steved@redhat.com,
       linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <17073.1156448708@warthog.cambridge.redhat.com>
References: <1156447974.5629.54.camel@localhost>
	 <1156432859.5629.24.camel@localhost>
	 <32511.1156263593@warthog.cambridge.redhat.com>
	 <7346.1156444521@warthog.cambridge.redhat.com>
	 <17073.1156448708@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:05:04 -0400
Message-Id: <1156449905.5629.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.928, required 12,
	autolearn=disabled, AWL 0.56, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 20:45 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > No. I find that mixture of < and <= is much less easy to read. Besides,
> > the compiler should be able to optimise that for me.
> 
> So you don't think they're mathematically equivalent?

The fact that they are mathematically equivalent does not make them
equivalently easy to read.

As long as the compiler is able to optimise it, we should be quite free
to choose one or the other style of code.

I therefore chose the style which explicitly lists the number of 32-bit
words we want to scan.

Trond

