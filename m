Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWJBUmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWJBUmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWJBUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:42:05 -0400
Received: from natreg.rzone.de ([81.169.145.183]:52897 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S965001AbWJBUmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:42:02 -0400
Date: Mon, 2 Oct 2006 22:40:55 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
Message-ID: <20061002204055.GA18735@aepfle.de>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com> <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com> <20061002165137.GK5670@kernel.dk> <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, Linus Torvalds wrote:

> Well, I already applied them, but I applied them as a single patch (since 
> 1/2 wasn't actually usable on its own _or_ even just a plain revert, and 
> 2/2 was really required for 1/2 to even compile).

The sigset_from_compat() calls in fs/compat.c have currently no
declaration of that function.
The change for include/linux/compat.h is appearently missing.
