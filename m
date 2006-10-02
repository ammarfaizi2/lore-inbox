Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWJBRF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWJBRF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWJBRF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:05:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932533AbWJBRFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:05:25 -0400
Date: Mon, 2 Oct 2006 10:05:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@kernel.dk>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
In-Reply-To: <20061002165137.GK5670@kernel.dk>
Message-ID: <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
 <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
 <20061002165137.GK5670@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Jens Axboe wrote:

> On Mon, Oct 02 2006, David Howells wrote:
> > From: David Howells <dhowells@redhat.com>
> > 
> > Make linux/compat.h #include asm/signal.h to gain a definition of
> > sigset_t so that it can externally declare sigset_from_compat().
> > 
> > This has been compile-tested for i386, x86_64, ia64, mips, mips64,
> > frv, ppc and ppc64 and run-tested on frv.
> 
> Ack both patches, thanks David.

Well, I already applied them, but I applied them as a single patch (since 
1/2 wasn't actually usable on its own _or_ even just a plain revert, and 
2/2 was really required for 1/2 to even compile).

		Linus
