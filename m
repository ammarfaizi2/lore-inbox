Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280617AbRKBJMG>; Fri, 2 Nov 2001 04:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280619AbRKBJL6>; Fri, 2 Nov 2001 04:11:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18048 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280617AbRKBJLs>;
	Fri, 2 Nov 2001 04:11:48 -0500
Date: Fri, 2 Nov 2001 04:11:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <20011102124252.1032e9b2.rusty@rustcorp.com.au>
Message-ID: <Pine.GSO.4.21.0111020359540.12621-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Nov 2001, Rusty Russell wrote:

> On Thu, 01 Nov 2001 05:42:36 -0500
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
> > Is this designed to replace sysctl?
> 
> Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.

Aha.  Like, say it, /proc/kcore.  Or /proc/mounts, yodda, yodda.

	Noble idea, but there is a little problem: random massive userland
breakage.  E.g. changing /proc/mounts is going to hit getmntent(3), etc.

	If you are willing to audit all userland code - you are welcome.
But keep in mind that standard policy is to keep obsolete API for at least
one stable branch with warnings and remove it in the next one.  So we are
talking about 2.8 here.  BTW, I'm less than sure that your variant is free
of rmmod races, but that's a separate story...

