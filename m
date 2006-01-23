Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWAXBDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWAXBDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWAXBDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:03:05 -0500
Received: from THUNK.ORG ([69.25.196.29]:13196 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030188AbWAXBDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:03:04 -0500
Date: Mon, 23 Jan 2006 16:34:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123213400.GC14409@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123185549.GA15985@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 07:55:49PM +0100, Matthias Andree wrote:
> The question that's open is one for the libc guys: malloc(), valloc()
> and others seem to use mmap() on some occasions (for some allocation
> sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
> if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
> is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
> then drops privileges.

Maybe mlockall(MLC_FUTURE) when run with privileges should
automatically adjust the RLIMIT_MEMLOCK resource limit?

					- Ted
