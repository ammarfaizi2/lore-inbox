Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSHCTsT>; Sat, 3 Aug 2002 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSHCTsT>; Sat, 3 Aug 2002 15:48:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39180 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317546AbSHCTsS>; Sat, 3 Aug 2002 15:48:18 -0400
Date: Sat, 3 Aug 2002 12:39:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Gerrit Huizenga <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208031441.29353.frankeh@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0208031237060.9758-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, Hubertus Franke wrote:
>
> But I'd like to point out that superpages are there to reduce the number of
> TLB misses by providing larger coverage. Simply providing page coloring
> will not get you there.

Superpages can from a memory allocation angle be seen as a very strict
form of page coloring - the problems are fairly closely related, I think
(superpages are just a lot stricter, in that it's not enough to get "any
page of color X", you have to get just the _right_ page).

Doing superpages will automatically do coloring (while the reverse is
obviously not true). And the way David did coloring a long time ago (if
I remember his implementation correctly) was the same way you'd do
superpages: just do higher order allocations.

			Linus

