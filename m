Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUA2WzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUA2WzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:55:21 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:58850 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266472AbUA2WzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:55:00 -0500
Date: Thu, 29 Jan 2004 23:54:56 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129225456.GM16675@khan.acc.umu.se>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <20040129233730.A19497@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129233730.A19497@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 11:37:30PM +0100, Andries Brouwer wrote:
> On Thu, Jan 29, 2004 at 09:15:56PM +0100, David Weinehall wrote:
> 
> > > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> > 
> > I can't really see the logic in this, though I know a lot of people do
> > it.  I try to stay consistent, thus I do:
> > 
> > if ()
> > for ()
> > case ()
> > while ()
> > sizeof ()
> > typeof ()
> > 
> > since they're all parts of the language, rather than
> > functions/macros or invocations of such.
> 
> As you say, this is religion. Secondly, there need not be any logic.
> But thirdly, if you insist: The first four are about flow of control.
> We all agree they have spaces - it is Linux kernel standard.
> 
> On the other hand, sizeof is an arithmetical expression, often part
> of larger expressions. Now expressions like
> 	sizeof (*foo)+1
> might be confusing, and
> 	sizeof(*foo) + 1
> shows more clearly what the parsing is.

You should at least compare apples to apples, that is:

sizeof (*foo) + 1

vs

sizeof(*foo) + 1

But I guess that was just a typo?  Of course, since the ()'s are useless
here anyway, and doesn't really bring any added bonus, we end up with

sizeof *foo + 1

vs

sizeof*foo + 1

and I'd say the latter looks rather confusing, if not for anything else
because

sizeoffoo

would be invalid code, while

sizeof foo

is perfectly valid.

This is the same as

return *foo;

vs

return*foo;

I personally regard the former to be preferable, but it's it's a
preference, not a something I'd die over.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
