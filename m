Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129613AbRCHUPi>; Thu, 8 Mar 2001 15:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRCHUP2>; Thu, 8 Mar 2001 15:15:28 -0500
Received: from waste.org ([209.173.204.2]:2388 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129613AbRCHUPR>;
	Thu, 8 Mar 2001 15:15:17 -0500
Date: Thu, 8 Mar 2001 14:13:55 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation for mm.h
In-Reply-To: <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0103081400450.30996-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Rik van Riel wrote:

> I've taken today to write some documentation for
> include/linux/mm.h, as used in 2.4.x

Mostly good.

> +	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */

But a lot of the comments are trivial = deadweight. Comments are best used
for the bits that are magical without them, which should be few.

> +	struct page *next_hash;		/* Next page sharing our hash bucket in
> +					   the pagecache hash table. */

Multiline comments at the end of the line are hard to maintain and highly
susceptible to tab damage.

> +	atomic_t count;			/* Usage count, see below. */
> +	unsigned long flags;		/* atomic flags, some possibly
> +					   updated asynchronously */

I'm sure there's a good reason why the flags aren't atomic_t but this
comment would make me suspect a bug. Comments that don't agree with code
are worse than no comments.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


