Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUFSXRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUFSXRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUFSXRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:17:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:13237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264771AbUFSXRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:17:00 -0400
Date: Sat, 19 Jun 2004 16:16:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7] ext3 fill_super reporting
Message-Id: <20040619161604.5afc8eab.akpm@osdl.org>
In-Reply-To: <1087684902.2224.31.camel@localhost.localdomain>
References: <1087684902.2224.31.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> wrote:
>
> Andrew,
> 
> This patch does the following :

> 	-Explicit max_per_group authorized for block, fragments, inodes 

Sorry, but this is just too trivial to be worth the processing.  The
compiler is perfectly capable of retaining the `blocksize * 8' result for
later use and this part of your patch actually increases the code size
slightly.

> 	-Remove groupmax recalculations

I don't know what this means.

> 	-When mounting ext2 or ^has_journal , we know filesystem is extX
> relevant.
> 
> 
> 	btw, I see a FIXME in journal_update for new journal creation.

There is no such thing as journal_update.  I assume you're referring to the
handling of the "journal=update" mount option.  Please be more careful when
identifying these things.

> Does it
> mean we should patch to have e.g. journalupdate=<filename> or that note
> is obsolete ?

No, I see no need to be able to convert an ext2 filesystem to ext3 within
the kernel.  Nobody will bother to work on this.
