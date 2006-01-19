Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161287AbWASEZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287AbWASEZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWASEZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:25:13 -0500
Received: from pat.uio.no ([129.240.130.16]:24968 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161287AbWASEZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:25:12 -0500
Subject: Re: Can you specify a local IP or Interface to be used on
	a	per	NFS mount basis?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43CF0768.60703@candelatech.com>
References: <43CECB00.40405@candelatech.com>
	 <1137631728.13076.1.camel@lade.trondhjem.org>
	 <43CEF7A6.30802@candelatech.com>
	 <1137641084.8864.3.camel@lade.trondhjem.org>
	 <43CF0768.60703@candelatech.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 23:24:58 -0500
Message-Id: <1137644698.8864.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.363, required 12,
	autolearn=disabled, AWL 1.45, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 19:28 -0800, Ben Greear wrote:

> > As David said, the place to fix it is in xs_bindresvport(), but there is
> > no support for passing this sort of information through the current NFS
> > binary mount structure. You would have to hack that up yourself.
> 
> I can think of some horrible hacks to grab info out of a text file based
> on the mount point or some other available info...but if I actually
> attempted to do it right..would you consider the patch for kernel
> inclusion?  Is it OK to modify the binary mount structure?

It is possible, yes: the binary structure carries a version number that
allows the kernel to distinguish the various revisions that the userland
mount program supports.

That said, the concensus at the moment appears to be that we should move
towards a text-based mount structure for NFS (like most of the other
filesystems have, and like NFSroot has) so I'd be reluctant to take
patches that define new binary structures.

Cheers,
  Trond

