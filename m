Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTDNTEG (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTDNTEG (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:04:06 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:19445 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S263857AbTDNTEB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:04:01 -0400
Date: Mon, 14 Apr 2003 12:15:15 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030414191512.GA4917@ca-server1.us.oracle.com>
References: <20030414175141.GS4917@ca-server1.us.oracle.com> <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:00:27AM -0700, Linus Torvalds wrote:
> Well, the thing is, we absolutely _do_ need to have the 8+8 split, in
> order to make old devices look the same old way for old binaries.

	Yes, and I support this 100%.

> The 16+16 split is not strictly necessary, but Andries pointed out to me
> that there are filesystems etc external storage that only support a 32-bit
> opaque dev_t, so we'd need to marshall the device number _some_ way for
> them anyway, and having a standard way to do that is better than having
> everybody come up with their own variations.

	Sure, but it's a marshall, not a reality.  One of the reasons
for choosing 64bits is that we can have large spaces for large things.
If a driver happens to get a number in the 16:16 space (or the 12:20
space, which I prefer as well), then it could run out of space and end
up with the multiple major problem.
	True, a truly dynamic scheme could make all of this irrelevant,
but I was just postulating that complexity isn't strictly necessary.
	I guess it is a trade off.  Do all devices greater than 8:8
become 32:32 and merely are masked to 16:16 on limited filesystems, or
do all devices smaller than 16:16/12:20 appear the same on all
filesystems, limited or not?

JOel

-- 

"You can get more with a kind word and a gun than you can with
 a kind word alone."
         - Al Capone

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
