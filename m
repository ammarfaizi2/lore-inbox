Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSC3XmG>; Sat, 30 Mar 2002 18:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSC3Xl4>; Sat, 30 Mar 2002 18:41:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50347 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293386AbSC3Xlr>;
	Sat, 30 Mar 2002 18:41:47 -0500
Date: Sat, 30 Mar 2002 18:41:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: <20020330232307.A2673@birdsnest.maths.tcd.ie>
Message-ID: <Pine.GSO.4.21.0203301838090.2590-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Mar 2002, Timothy Murphy wrote:

> I'm sure this has been recognised,
> but I would point out that sys_nfsservctl is not "undefined"
> if NFSD is not chosen.
> 
> The following patch to .../arch/i386/kernel/entry.S corrects this,
> though this is obviously not the right place to put it:

Wrong fix.  Using weak aliases would do it in cleaner way, but there's
a sparc64 toolchain bugs that don't allow that.

	Dave, you've mentioned doing the equivalent of
__attribute__((weak,alias("foo")) by hand.  Could you give an example?

