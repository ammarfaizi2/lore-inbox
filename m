Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbRL3UMD>; Sun, 30 Dec 2001 15:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRL3ULx>; Sun, 30 Dec 2001 15:11:53 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:8200 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S284794AbRL3ULk>;
	Sun, 30 Dec 2001 15:11:40 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Cc: <andihartmann@freenet.de>
Subject: RE: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 30 Dec 2001 12:11:12 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBKEOJEEAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3C2F18A5.B50792F0@sirius-cafe.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My main "problem" with 2.4 as well. Using free memory for Cache/Buffers
> is great, but only as long as the memory is not needed for running
> tasks. As soon as a task is requesting more memory, it should be first
> taken from Cache/Buffer (they are caches, aren't they :-). Only if this
> has been used up (to a tunable minimum, see below), swapping and finally
> OOM killing should happen.
>
> To prevent completely trashing IO performance, there should be tunable
> parameters for minimum and maximum Cache/Buffer usage (lets say in
> percent of total memory). Maybe those tunables are even there today and
> I am just to stupid to find them :-))

Yes!! I second that motion!! On top of that, we need buffer/page cache hit
rate statistics!! Once your read hit rate gets up into the high 90
percentages, more buffer/page cache memory is wasted.

If Linux is to succeed in enterprise-level usage, we *must* have tools to
measure, manage and tune performance -- in short, to do capacity planning
like we do on any other system. And the kernel variables that affect
performance *must* be under control of the system administrator and
ultimately the machine's *customers*, *not* a bunch of kernel geeks! That
means keeping them in variables accessible by a system administrator, *not*
#defines in code that must be entirely recompiled when you want to tweak a
parameter.

If you build it, they will come :). If you *refuse* to build it, they will
use something else -- it's as simple as that.
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

