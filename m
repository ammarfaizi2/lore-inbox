Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbUCSAeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUCSAeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:34:19 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:38310 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263345AbUCSAdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:33:23 -0500
Date: Fri, 19 Mar 2004 01:32:52 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319003252.GB11450@wohnheim.fh-wedel.de>
References: <20040318231006.GK11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040318231006.GK11010@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 March 2004 17:10:06 -0600, Matt Mackall wrote:
> 
> I've reworked the mess that is lib/inflate.c, including:
> 
> - proper formatting
> - killing a ton of legacy code
> - cleaning up IO and CRC handling
> - eliminating all the global variables
> - using __init for the core kernel
> - proper linking rather than the #include "../lib/inflate.c" hack
> - lots of minor cleanups along the way
> 
> This drops a ton of support code from all the users of this code as
> well:
> 
>  arch/arm/boot/compressed/Makefile    |    5
>  arch/arm/boot/compressed/misc.c      |  244 --
>  arch/i386/boot/compressed/Makefile   |    6
>  arch/i386/boot/compressed/misc.c     |  224 --
>  arch/x86_64/boot/compressed/Makefile |    6
>  arch/x86_64/boot/compressed/misc.c   |  212 --
>  include/linux/inflate.h              |    9
>  init/do_mounts_rd.c                  |  129 -
>  init/initramfs.c                     |  139 -
>  lib/Makefile                         |    4
>  lib/inflate.c                        | 3047 ++++++++++++++++-----------------
>  11 files changed, 1688 insertions(+), 2337 deletions(-)

I like the patch in general.  This is definitely the wrong time for
it, but at least parts of it could go into 2.7 sometime.

Have you thought about updating to a more recent version of zlib?  It
is most likely not worth it but I'd like to know for sure.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
