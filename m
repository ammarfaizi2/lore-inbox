Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTHOT4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHOT4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:56:07 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:45255 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S270700AbTHOT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:56:05 -0400
Date: Fri, 15 Aug 2003 14:56:02 -0500
From: mouschi@wi.rr.com
Subject: Re: Interesting VM feature?
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Reply-to: mouschi@wi.rr.com
Message-id: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.12 (built Feb 13 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> You can call madvise(start, length, MADV_DONTNEED),
> or you can mmap() fresh empty pages into the region.

madvise appears to be exactly what I'm looking for.
(almost...)

> I have no idea if either of these methods is
efficient enough to be
> useful.  Also, I don't know whether mmap() would
create multiple VMAs,
> or if it is clever enough to merge adjacent vmas
of anonymous private
> mappings regardles of offset.

Enough possible pitfalls that madvise becomes the
better solution.

> The ideal implementation would give the kernel the
_option_ of
> discarding pages until they are next touched, so
that they are
> discarded when there is memory pressure but
retained if not, avoiding
> the unnecessary zero-fill and cache flush.

Is madvise required to result in zero filled pages
by a standard, or is this just the commonly accepted
behavior?

> -- Jamie

Thanks a bunch,
Ted

