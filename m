Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUHAXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUHAXLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHAXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 19:11:42 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8081 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266149AbUHAXLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 19:11:41 -0400
Date: Mon, 2 Aug 2004 01:10:47 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: chris@scary.beasts.org, Andrea Arcangeli <andrea@cpushare.com>,
       Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
Message-ID: <20040801231047.GI6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random> <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com> <20040801150119.GE6295@dualathlon.random> <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com> <1091393114.31139.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091393114.31139.5.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 09:45:14PM +0100, Alan Cox wrote:
> You can already do all of this using several user space applications
> that manage it via ptrace. They do have a performance hit however.

the tracer can be killed by oom due some other random app in the
machine, plus SIGCHLD may confuse the tracer, then it needs to know
about arch details again (like the bitmap), and the whole ptrace
infastructure is a lot more complicate and in turn less secure. syscall
performance is the last worry (at least for my usage).
