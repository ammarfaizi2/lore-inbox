Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272152AbTHICUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 22:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272153AbTHICUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 22:20:40 -0400
Received: from mail.suse.de ([213.95.15.193]:64013 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272152AbTHICUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 22:20:39 -0400
Date: Sat, 9 Aug 2003 04:20:38 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Restore current->files in flush_old_exec
In-Reply-To: <20030809014830.GA11509@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.53.0308090418270.18879@Chaos.suse.de>
References: <20030808105321.GA5096@gondor.apana.org.au>
 <20030809010736.GA10487@gondor.apana.org.au> <20030809011116.GB10487@gondor.apana.org.au>
 <20030809014830.GA11509@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Herbert Xu wrote:

> On Sat, Aug 09, 2003 at 11:11:16AM +1000, herbert wrote:
> >
> > At this point, I believe the unshare_files stuff should be fine from
> > a correctness point of view.  However, there is still a performance
> > problem as every ELF exec call ends up dupliating the files structure
> > as well as walking through all file locks.
>
> Here is the patch that ensures files is only duplicated when necessary.

This patch is correct but unnecessary: steal_locks already tests for this
condition.


Cheers,
Andreas.
