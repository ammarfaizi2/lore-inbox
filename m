Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbTGJEBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 00:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268903AbTGJEBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 00:01:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268883AbTGJEBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 00:01:50 -0400
Date: Wed, 9 Jul 2003 21:16:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org
Subject: Re: RFC:  what's in a stable series?
Message-Id: <20030709211645.40353fc2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
References: <3F0CBC08.1060201@pobox.com>
	<Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> Its a case-by-case problem.

It is.  Generally I think we should prefer to do the right thing rather
than adhering to the old API out of some principle.

Evaluate the impact on out-of-tree kernel patches (especially vendor
kernels) and if it is unacceptable then reject the change or augment the API
rather than changing it.

>  I reverted the direct IO patches because hch complained on me that they
>  change the direct IO API, and we really dont want that kind of
>  change, IMHO.

OK, we're on to a specific case.  Albeit a very small one.

I think Trond's direct IO change was right.  The impact on out-of-tree code
is infinitesimal.  Stick a #define O_DIRECT_NEEDS_A_FILP in the header and
let the XFS guys write a four-line patch.  There's no point in mucking up
the kernel API to save such a small amount of work.

Or merge XFS.


