Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTKFN6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTKFN6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:58:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263614AbTKFN6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:58:01 -0500
Date: Thu, 6 Nov 2003 08:59:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Scott Robert Ladd <coyote@coyotegulch.com>
cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
In-Reply-To: <3FAA4C26.9080900@coyotegulch.com>
Message-ID: <Pine.LNX.4.53.0311060838180.3117@chaos>
References: <20031105204522.GA11431@work.bitmover.com> <20031105225134.GA14149@win.tue.nl>
 <20031106070721.GA18028@mcgroarty.net> <200311061141.00595.andrew@walrond.org>
 <3FAA4C26.9080900@coyotegulch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Scott Robert Ladd wrote:

> Andrew Walrond wrote:
> > Somebody getting access to and inserting exploits directly into the linux
> > source is not something we should take lightly. Whilst we understand the
> > limits of the problem, the fact that it happened at all could get /.'d out of
> > all proportion and be used to seriously undermine linux's reputation
>
> Well, it's hit /. and OSNews already this morning.
>
> Mainstream media is now aware of Linux; for better or worse, someday, an
> issue like this is going to leak beyond Slashdot onto the pages of the
> Wall Street Journal and ZDNet. Maybe not this time -- but eventually.
>
> Open development is the ultimate in honesty -- and honesty leaves us
> vulnerable to being bitten by the ignorati and anti-freedom forces.
>
> --
> Scott Robert Ladd
> Coyote Gulch Productions (http://www.coyotegulch.com)
> Software Invention for High-Performance Computing

This may not really be the problem. It is well known that
anybody who has the capabilities of inserting a module into
the most secure kernel in the universe, could have designed
the module to give the current caller root privs when some
module function is executed.

$ whoami
cracker
$ od /dev/TROJAN
$ whoami
root
$

The kernel sources can be inspected using automation, looking
for accesses to 'current'. The expected patterns can be ignored.
Accesses to current->XXX,current->YYY,current->YYY, etc., could be
reviewed. However, this doesn't stop the clever programmer who
creates a pointer that, using a difficult-to-follow path, has
access to these structure members.

So, basically, any open-source kernel is vulnerable. Also any
closed-source kernel is also vulnerable. We already know that
M$ had hundreds of bugs, perhaps more, that allowed a hacker
complete unrestricted access to a machine on the network. We
also know that there are deliberate back-doors inserted to
allow governments to inspect the contents of these computers
(search on magic lantern and carnivor).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


