Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTHOVTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTHOVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:19:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54401 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270982AbTHOVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:19:38 -0400
Date: Fri, 15 Aug 2003 22:19:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: mouschi@wi.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Interesting VM feature?
Message-ID: <20030815211937.GA20208@mail.jlokier.co.uk>
References: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com> <20030815200020.GM1027@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815200020.GM1027@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Fri, Aug 15, 2003 at 02:56:02PM -0500, mouschi@wi.rr.com wrote:
> > Is madvise required to result in zero filled pages
> > by a standard, or is this just the commonly accepted
> > behavior?
> 
> I believe it is the standard for clean pages, though someone else will have
> to point out where...

That's the answer to a different question.

The unanswered question is: what should madvise(MADV_DONTNEED) do,
given dirty pages?

man madvise(*) says that it zero-fills anonymous private mappings, and
restores private file-backed mappings to the original file pages.

That is not surprising, as the CPU-friendly semantic is more
complicated to implement, needing an extra flag in the page table
(or rmap structure).

-- Jamie
