Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSHRK0c>; Sun, 18 Aug 2002 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHRK0b>; Sun, 18 Aug 2002 06:26:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8947 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313867AbSHRK0a>; Sun, 18 Aug 2002 06:26:30 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 11:30:05 +0100
Message-Id: <1029666605.15858.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 04:25, Linus Torvalds wrote: 
> Hmm.. After more reading, it looks like (if I understood correctly), that
> since network activity isn't considered trusted -at-all-, your average
> router / firewall / xxx box will not _ever_ get any output from
> /dev/random what-so-ever. Quite regardless of the context switch issue,
> since that only triggers for trusted sources. So it was even more
> draconian than I expected.

The current policy has always been not to trust events that are
precisely externally controllable. Oliver hasn't changed the network
policy there at all.

Its probably true there are low bits of randomness available from such
sources providing we know the machine has a tsc, unless the I/O APIC is
clocked at a divider of the processor clock in which case our current
behaviour is probably much saner.

With modern systems that have real RNG's its a non issue.

