Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317051AbSFAUOd>; Sat, 1 Jun 2002 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317055AbSFAUOc>; Sat, 1 Jun 2002 16:14:32 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:31668 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S317051AbSFAUOb>;
	Sat, 1 Jun 2002 16:14:31 -0400
Date: Sat, 1 Jun 2002 16:14:24 -0400
From: Jeff Garzik <garzik@gtf.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 10/16] give swapper_space a set_page_dirty a_op
Message-ID: <20020601161424.A4535@gtf.org>
In-Reply-To: <3CF88908.179B10BF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 01:42:48AM -0700, Andrew Morton wrote:
> 
> 
> Give swapper_space a ->set_page_dirty() address_space_operation.

Remember that we don't need swapper_space at all?

All the underlying inodes have their own address spaces, and the
SWP_ENTRY tells us what we need to know, to find the underlying address
spaces.

swapper_space is just a master address space that overlays the
underlying multiple address spaces.  We can just look directly at the
underlying ones...

	Jeff



