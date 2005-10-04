Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVJDWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVJDWfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVJDWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:35:11 -0400
Received: from [203.171.93.254] ([203.171.93.254]:34775 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S965024AbVJDWfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:35:09 -0400
Subject: Re: [swsusp] separate snapshot functionality to separate file
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051004205334.GC18481@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz>
	 <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz>
	 <200510041711.13408.rjw@sisk.pl>  <20051004205334.GC18481@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128465272.6611.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 05 Oct 2005 08:34:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-10-05 at 06:53, Pavel Machek wrote:
> > > That does not belong to snaphost. The rest is notthat clear, but I have it
> > > working in userspace.
> > 
> > Of course it is doable in the userland, but this does not mean it should be
> > done in the userland.  Personally I don't think so (please see
> > below).
> 
> Even if you don't agree with putting it to userland (and that's
> neccessary -- if we want some features from suspend2), split still
> makes sense.

Not necessary, but desirable in your eyes. I can see that you can make
it work if you're only talking about implementing eye candy, but if
you're serious about adding the substantial improvements from Suspend2
(support for multiple swap partitions, swap files, block sizes != 4096,
asynchronous I/O, readhead where I/O must be synchronous, support for
writing to a network or a generic file (again with block size != 4096)
etc, - let alone support for saving a full image of memory - this is
just going to get uglier and uglier. We can see this already because
you've already dropped swap support, obviously because it's too hard
from userspace.

The tidy up you're proposing is a nice step. But it seems to me to be 
the only good thing and really useful thing to come of this so far.

Pavel, at the PM summit, we agreed to work toward getting Suspend2
merged. I've been working since then on cleaning up the code, splitting
the patches up nicely and so on. In the meantime, you seem to have gone
off on a completely different tangent, going right against what we
agreed then. Can I get you to at least try to come back from that? I'd
be more than willing to help you with cherry picking some changes and
getting them in ahead of the rest of the code. Would you consider
working together to do that? In particular, I'm thinking that I could
send you the refrigerator patches as I have them at the moment, and a
patch to remove the reliance on PageReserved, at least for a start. Any
willingness on your part to give that a try?

Regards,

Nigel
-- 


