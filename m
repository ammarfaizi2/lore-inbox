Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265280AbUETXaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUETXaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbUETXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:30:21 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:55069 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265280AbUETXaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:30:14 -0400
Date: Thu, 20 May 2004 18:30:13 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jirka Kosina <jikos@jikos.cz>, linux-kernel@vger.kernel.org,
       pekkas@netcore.fi
Subject: Re: [PATCH] IPv6 can't be built as module additionally
Message-ID: <20040520233012.GA15699@hexapodia.org>
References: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz> <20040520155042.223b05e3.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520155042.223b05e3.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 03:50:42PM -0700, David S. Miller wrote:
> On Fri, 21 May 2004 00:16:06 +0200 (CEST)
> Jirka Kosina <jikos@jikos.cz> wrote:
> > This is because ipv6-specific functions in drivers/char/random.c 
> > are inside #ifdefs, and as random.c is almost always built directly into 
> > kernel, recompilation of whole kernel can't be avoided.
> 
> This is the smallest problem, several main kernel data structures
> change size based upon whether ipv6 has been enabled in any way
> or not.
> 
> So even with your patch, compiling ipv6 outside of the kernel will
> still not work even though it might build.

Dave, would you be opposed to making IPv6 the default, with IPv4-only a
selectable option under CONFIG_EMBEDDED or whatever umbrella "I know
what I'm doing, let me remove vital parts of the kernel" config option
is considered appropriate?

It seems that the cost of IPv6 is small enough in most scenarios that
virtually everyone should be enabling it, and those who turn it off
should be willing to turn on CONFIG_EMBEDDED or whatever the umbrella
option is called.  I note with dismay that of the 18 arch/*/defconfig
files I perused, 13 do not set CONFIG_IPV6, 3 have =m, and 2 have =y.

-andy
