Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLUAk2>; Wed, 20 Dec 2000 19:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLUAkT>; Wed, 20 Dec 2000 19:40:19 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:56585 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129413AbQLUAkK>; Wed, 20 Dec 2000 19:40:10 -0500
Date: Thu, 21 Dec 2000 01:09:35 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Steve Grubb <ddata@gate.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] performance enhancement for simple_strtoul
Message-ID: <20001221010935.A22817@pcep-jamie.cern.ch>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master> <20001220100446.A1249@inetnebr.com> <001401c06ab4$ac8615e0$7d1a24cf@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001401c06ab4$ac8615e0$7d1a24cf@master>; from ddata@gate.net on Wed, Dec 20, 2000 at 01:42:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Grubb wrote:
> It seems gcc creates much better code with the variables set to register
> types.

Curious.  GCC should be generating the same code regardless; ah well.

Is strtoul actually used in the kernel other than for the occasional
(rare) write to /proc/sys and parsing boot options?

> But this is the kernel and there are people that would reject my patch
> purely on the basis that it adds precious bytes to the kernel.

Perhaps I am mistaken but I'd expect it to be called what, ten times at
boot time, and a couple of times when X loads the MTRRs?

Sounds like the neatest trick would be reducing bytes used here...

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
