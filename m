Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWJBVBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWJBVBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWJBVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:01:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965113AbWJBVBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:01:14 -0400
Date: Mon, 2 Oct 2006 14:00:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
In-Reply-To: <20061002204055.GA18735@aepfle.de>
Message-ID: <Pine.LNX.4.64.0610021355330.3952@g5.osdl.org>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
 <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
 <20061002165137.GK5670@kernel.dk> <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
 <20061002204055.GA18735@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Olaf Hering wrote:
> On Mon, Oct 02, Linus Torvalds wrote:
> 
> > Well, I already applied them, but I applied them as a single patch (since 
> > 1/2 wasn't actually usable on its own _or_ even just a plain revert, and 
> > 2/2 was really required for 1/2 to even compile).
> 
> The sigset_from_compat() calls in fs/compat.c have currently no
> declaration of that function.
> The change for include/linux/compat.h is appearently missing.

Yeah, damn, I don't know what happened there. I fixed the patch, but then 
actually applied the old version, it looks like.

Duh.

		Linus "uhh.. Too little coffee?" Torvalds
