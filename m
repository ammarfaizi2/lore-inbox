Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291901AbSBASaS>; Fri, 1 Feb 2002 13:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291905AbSBASaI>; Fri, 1 Feb 2002 13:30:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33700 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291901AbSBAS3z>;
	Fri, 1 Feb 2002 13:29:55 -0500
Date: Fri, 1 Feb 2002 13:29:53 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Momchil Velikov <velco@fadata.bg>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201132953.A27508@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain> <Pine.LNX.4.33.0202010903060.2634-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202010903060.2634-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 01, 2002 at 09:06:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:06:37AM -0800, Linus Torvalds wrote:
> Even databases often use multiple files, and quite frankly, a database
> that doesn't use mmap and doesn't try very hard to not cause extra system
> calls is going to be bad performance-wise _regardless_ of any page cache
> locking.

I've always thought that read(2) and write(2) would in the end wind up
faster than mmap(2)...  Tests in my rewritten cp/rm/mv type utilities
seem to bear this out.

Is mmap(2) only preferred for large files/databases?

	Jeff



