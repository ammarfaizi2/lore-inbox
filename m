Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUCKC34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUCKC34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:29:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:42921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262953AbUCKC3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:29:54 -0500
Date: Wed, 10 Mar 2004 18:36:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Williams <peterw@aurema.com>
cc: root@chaos.analogic.com, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Subject: Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <404F9E28.4040706@aurema.com>
Message-ID: <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
 <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos>
 <404F9E28.4040706@aurema.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Mar 2004, Peter Williams wrote:
> Richard B. Johnson wrote:
> > 
> > People who develop kernel code know the difference between
> > '==' and '=' and are never confused my them.
> 
> And you never make typing mistakes?  That's admirable or should I say 
> incredible.

The thing is, people tend to make fewer typing mistakes of that kind, than 
just plain logic errors from not thinking right about something.

And while "0 == foo" may be logically the same thing as "foo == 0", the 
fact is, the latter is what people are used to seeing. And by being used 
to seeing it, they have an easier time thinking about it.

As a result, using the former just tends to increase peoples confusion by
making code harder to read, which in turn tends to increase the chance of 
bugs.

So don't do it. The kind of bug that the "0 == x" syntax protects against
is LESS LIKELY to happen than the kind of bug it tends to cause.

		Linus
