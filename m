Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTESXVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTESXVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:21:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45698 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263275AbTESXVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:21:05 -0400
Date: Tue, 20 May 2003 00:33:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
Message-ID: <20030519233353.GD13706@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0305190814300.16317-100000@home.transmeta.com> <Pine.LNX.4.44.0305191752130.13233-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305191752130.13233-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > >  - start the phasing out of FUTEX_FD. This i believe is quite unclean and
> > >    unrobust, [...]
> 
> FUTEX_FD is an instant DoS, it allows the pinning of one page per file
> descriptor, per thread. With a default limit of 1024 open files per
> thread, and 256 threads (on a sane/conservative setup), this means 1 GB of
> RAM can be pinned down by a normal unprivileged user.

The correct solution [;)] is EP_FUTEX - allow a futex to be specified
as the source of an epoll event.

-- Jamie
