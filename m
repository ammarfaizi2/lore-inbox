Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTEKDjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 23:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEKDjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 23:39:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262109AbTEKDjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 23:39:47 -0400
Date: Sat, 10 May 2003 20:50:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Jos Hulzink <josh@stack.nl>, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <20030510181056.GB29682@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 May 2003, Jamie Lokier wrote:
> Jos Hulzink wrote:
> > For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0 
> > vector, unless someone can hand me a paper that says it is wrong.
> 
> I agree, for the simple reason that it is what the chip does on a
> hardware reset signal.

Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
isn't even really true real mode? I have this memory that the reset value
for a i386 has CS=0xf000, but the shadow base register actually contains
0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
and will fetch the first instruction from physical address 0xfffffff0.

At least that was true on an original 386. It's something that could 
easily have changed since.

In other words, you're all wrong. Nyaah, nyaah.

			Linus

