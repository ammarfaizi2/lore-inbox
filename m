Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTLZG6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 01:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLZG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 01:58:43 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:27169 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265161AbTLZG6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 01:58:41 -0500
Date: Fri, 26 Dec 2003 00:58:40 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
Message-ID: <20031226005840.A30827@hexapodia.org>
References: <1072403207.17036.37.camel@clubneon.clubneon.com> <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>; from torvalds@osdl.org on Thu, Dec 25, 2003 at 08:34:33PM -0800
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 08:34:33PM -0800, Linus Torvalds wrote:
> The cast/conditional expression as lvalue are _particularly_ ugly 
> extensions, since there is absolutely zero point to them. They are very 
> much against what C is all about, and writing something like this:
> 
> 	a ? b : c = d;
> 
> is something that only a high-level language person could have come up 
> with. The _real_ way to do this in C is to just do
> 
> 	*(a ? &b : &c) = d;
> 
> which is portable C, does the same thing, and has no strange semantics.

But doesn't the first one potentially let the compiler avoid spilling to
memory, if b and c are both in registers?

Not that I'm fond of gccisms, but this one at least seems to have a
potential value.  And I'm sure I came up with an instance of it making
my head ache, a while back, but I can't come up with a bad example now.
Care to elaborate on your "strange semantics"?

-andy
