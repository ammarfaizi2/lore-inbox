Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbULCCYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbULCCYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 21:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbULCCYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 21:24:37 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:37387 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261895AbULCCY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 21:24:28 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "James Bruce" <bruce@andrew.cmu.edu>, "J.A. Magallon" <jamagallon@able.es>
Cc: "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: What if?
Date: Thu, 2 Dec 2004 18:23:16 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEKLADAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20041202202514.GA5882@thunk.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 02 Dec 2004 17:59:34 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 02 Dec 2004 17:59:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> While that may be true, the problem is that you don't know off the top
> of your head whether something like:
>
> 	a = b + c + d + e;
>
> involves primitive types or not just by inspection.  So it could be
> something that takes no time at all, or a monstrosity which takes a
> dozen or more memory allocations, and where it requires a Ph.D. in
> understanding obfuscated code to figure out which overloaded operators
> and which type coercions had actually taken place.  And remember, this
> is a language where you can even override the comma (',') operator.
> You think you know what a piece of code will do just by looking at it?
> Think again!

	You can write bad code in any language.

> That's the problem with C++; it is far too easy to misuse.  And with a
> project as big as the Linux Kernel, and with as many contributors as
> the Linux Kernel, at the end of the day, it's all about damage
> control.  If we depend on peer review to understand whether or not a
> patch is busted, it is rather important that something as simple as
>
> 	a = b + c;
>
> does what we think it does, and not something else because someone has
> overloaded the '+' operator.  Or God help us, as I have mentioned
> earlier, the comma operator.

	The UNIX way is to allow people to shoot themselves in the foot.
Overloading the comma operator is shooting yourself in the foot. If being
allowed to overload it is bad, then being allowed to do anything harmful is
bad.

> > In short, with C++ you can generate code as efficient as C or asm.
> > You just have to know how.
>
> You can juggle running chain saws if you know how, too.  But I think I
> would rather leave that to the Flying Karamazov Brothers.

	I know all the reasons why writing a kernel in C++ is bad, and I largely
agree with them. However, this argument I don't find convincing.

	The part of it that's correct is just this: with C++, it can be harder to
tell exactly what a line of code does under the hood. For user-space code,
the vast majority of the time, that's great, it saves you from having to do
a whole lot of work. However, for kernel code, the vast majority of the
time, you must understand exactly what's going on under the hood.

	DS


