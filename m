Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUGXFqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUGXFqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUGXFqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:46:14 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:41458 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268300AbUGXFqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:46:07 -0400
Date: Fri, 23 Jul 2004 22:45:53 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724054553.GA31072@taniwha.stupidest.org>
References: <1090604517.13415.0.camel@lucy> <20040723200335.521fe42a.akpm@osdl.org> <1090635297.1830.4.camel@localhost> <20040724051550.GA30718@taniwha.stupidest.org> <1090647702.2296.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090647702.2296.59.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 01:41:42AM -0400, Robert Love wrote:

> I would be for this, although the situation is really no different
> than today with printk()'s, which I would hope could be replaced in
> some cases with the events (an either-or kind of deal).  Dunno.

except we don't (usually) have daemons listening for printk strings
and doing something very specific based upon them such as scanning new
media

> This is a good idea for other reasons, too: the common base of
> errors could be certified as supported by the error daemon,
> translated, etc.  etc.

by guess is most driver errors will belong to a small common subset

> I am not sure how realistic this goal is, but I do like it, at least
> for the general case of the usual errors in drivers.

all the more reason why they should be placed somewhere non-trivial so
we can discuss what exactly is required and suitable on a case-by-case
basis

my fear is that if we don't do this we will have n different events
for 'disk bad' for n different hba drivers (for example)


  --cw
