Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266942AbRGXFZN>; Tue, 24 Jul 2001 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbRGXFZE>; Tue, 24 Jul 2001 01:25:04 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:35076 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266967AbRGXFYz>;
	Tue, 24 Jul 2001 01:24:55 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107240524.f6O5OwX286884@saturn.cs.uml.edu>
Subject: Re: Yet another linux filesytem: with version control
To: lm@bitmover.com (Larry McVoy)
Date: Tue, 24 Jul 2001 01:24:57 -0400 (EDT)
Cc: jerome.de-vivie@wanadoo.fr (Jerome de Vivie), linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org, martizab@libertsurf.fr,
        rusty@rustcorp.com.au
In-Reply-To: <20010723141751.W6820@work.bitmover.com> from "Larry McVoy" at Jul 23, 2001 02:17:51 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Larry McVoy writes:

> b) Filesystem support for SCM is really a flawed approach.  No matter how
>    much you hate all SCM systems out there, shoving the problem into the
>    kernel isn't the answer.  All that means is that you have an ongoing
>    battle to keep your VFS up to date with the kernel.  Ask Rational
>    how much fun that is...

I'm sure it is a pain to maintain, but consider recovery
with revision control in your root filesystem:

LILO: linux init=/bin/sh rootfsopts=ver:/bin/sh@@/main/1

Nice, isn't it? You can trash /bin/* all you want.

Distributed filesystems like Coda seem to get pretty close
to having revision control anyway. They need something like
it for conflict resolution.

The traditional revision control approach seems to get pretty
wasteful as well. Maybe you have a few dozen developers, each
with a few files checked out of a multi-gigabyte source tree.
The kernel solution has less trouble sharing resources among
all the developers, especially when people share a machine.

