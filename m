Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUGXFla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUGXFla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUGXFla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:41:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19606 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268297AbUGXFl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:41:28 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040724051550.GA30718@taniwha.stupidest.org>
References: <1090604517.13415.0.camel@lucy>
	 <20040723200335.521fe42a.akpm@osdl.org> <1090635297.1830.4.camel@localhost>
	 <20040724051550.GA30718@taniwha.stupidest.org>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 01:41:42 -0400
Message-Id: <1090647702.2296.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 22:15 -0700, Chris Wedgwood wrote:

> This part worries me a lot.  I would alsmost rather all possible
> messages get stuck somewhere common so driver writes can't add these
> ad-hoc and we can avoid a proliferation of either similar or pointless
> messages.

I would be for this, although the situation is really no different than
today with printk()'s, which I would hope could be replaced in some
cases with the events (an either-or kind of deal).  Dunno.

> Forcing these into a common place lets people eyeball if a new
> messages really is necessary --- and it makes writing applications to
> deal with these things easier (since you don't have to scan the entire
> kernel tree).

This is a good idea for other reasons, too: the common base of errors
could be certified as supported by the error daemon, translated, etc.
etc.

I am not sure how realistic this goal is, but I do like it, at least for
the general case of the usual errors in drivers.

	Robert Love


