Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbTAFXsp>; Mon, 6 Jan 2003 18:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTAFXsp>; Mon, 6 Jan 2003 18:48:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:55283 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267182AbTAFXso>;
	Mon, 6 Jan 2003 18:48:44 -0500
Message-ID: <3E1A17DB.D400C900@digeo.com>
Date: Mon, 06 Jan 2003 15:57:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configurable LOG_BUF_SIZE (updated)
References: <Pine.LNX.4.33L2.0301061257160.15416-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33L2.0301061523360.15416-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 23:57:15.0815 (UTC) FILETIME=[56C91B70:01C2B5DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> ...
>  arch/alpha/Kconfig     |   27 +++++++++++++++++++++++++++
>  arch/arm/Kconfig       |   27 +++++++++++++++++++++++++++
>  arch/cris/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/i386/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/ia64/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/m68k/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/m68knommu/Kconfig |   27 +++++++++++++++++++++++++++
>  arch/mips/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/mips64/Kconfig    |   27 +++++++++++++++++++++++++++
>  arch/parisc/Kconfig    |   27 +++++++++++++++++++++++++++
>  arch/ppc/Kconfig       |   27 +++++++++++++++++++++++++++
>  arch/ppc64/Kconfig     |   27 +++++++++++++++++++++++++++
>  arch/s390/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/s390x/Kconfig     |   27 +++++++++++++++++++++++++++
>  arch/sh/Kconfig        |   27 +++++++++++++++++++++++++++
>  arch/sparc/Kconfig     |   27 +++++++++++++++++++++++++++
>  arch/sparc64/Kconfig   |   27 +++++++++++++++++++++++++++
>  arch/um/Kconfig        |   27 +++++++++++++++++++++++++++
>  arch/v850/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/x86_64/Kconfig    |   27 +++++++++++++++++++++++++++
>  init/Kconfig           |   45 ---------------------------------------------
>  21 files changed, 540 insertions(+), 45 deletions(-)

Oh gack.   And you've got stuff like "if numaq" in the sparc64
config files.

You did have a version which instantiated a common $TOPDIR/kernel/Kconfig
and just included that in arch/<arch>/Kconfig.  Seems a better
approach to me.
