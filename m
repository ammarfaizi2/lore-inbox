Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266637AbUBMBM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUBMBM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:12:26 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:59397 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S266637AbUBMBMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:12:19 -0500
Date: Thu, 12 Feb 2004 20:12:13 -0500
To: Michael Frank <mhf@linuxmail.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-ID: <20040213011213.GB25298@fieldses.org>
References: <200402130615.10608.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130615.10608.mhf@linuxmail.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 06:15:10AM +0800, Michael Frank wrote:
> +Note that perhaps the most terrible way to write code is to put multiple
> +statements onto a single line:

If you can't manage Linus's sense of humor, go for something simple that
doesn't call attention to itself; e.g., "Don't put multiple statements
on a single line:"

> +Lagging spaces are deprecated.

Does everyone know immediately what "Lagging spaces" means?  "Trailing
spaces" seem to be more common usage.  "Don't leave whitespace at the
end of lines" might be clearest.

> +The limit on the length of lines is 80 columns and this is a hard limit.
> +
> +Statements longer than 80 columns will be broken into sensible chunks.
> +The beginning of a statement is the parent and further chunks are
> +descendent's. Descendent's are always shorter than the parent and

The last vowel of descendant (in the sense you're using it) is an "a",
and its plural is descendants.

Surely this section is overkill for a discussion of line lengths.  The
current document has the advantage of being short.

> +Centralized exiting of functions

That, on the other hand, is something worth documenting.

> +Complex expressions are easier to understand and maintain when extra
> +parenthesis are used. Here is an extreme example
> +
> +x = (((a + (b * c)) & d) | e)  // would work also without any parenthesis

Ugh.  This isn't LISP here.  The number of operators in C does make
keeping track of precedence tricky, but readers should be expected to
know a few things (like that * is higher precedence than +).  I'd just
leave out this discussion entirely.  CodingStyle is not, I think, meant
to be a complete C style guide.

> +Periods terminating kernel messages are deprecated

> +Usage of the apostrophe <'> in kernel messages is deprecated

> +Printing numbers in parenthesis ie (%d) is deprecated

I find the "X is deprecated" construction a little awkward.  In any case
it's overused here.

--Bruce Fields
