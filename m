Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHBTnq>; Fri, 2 Aug 2002 15:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSHBTnq>; Fri, 2 Aug 2002 15:43:46 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:61452 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S317152AbSHBTnm>; Fri, 2 Aug 2002 15:43:42 -0400
Date: Fri, 2 Aug 2002 12:47:01 -0700
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Alexander Viro <viro@math.psu.edu>,
       Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
Message-ID: <20020802194701.GB4528@bluemug.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Thunder from the hill <thunder@ngforever.de>,
	Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
	Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0208011610020.12627-100000@weyl.math.psu.edu> <200208012124.g71LObi394284@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208012124.g71LObi394284@saturn.cs.uml.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 05:24:37PM -0400, Albert D. Cahalan wrote:
> Alexander Viro writes:
> > [...]
> >> On Wed, 31 Jul 2002, Alexander Viro wrote:
> 
> >>> What the bleedin' hell is wrong with <name> <start> <len>\n
> >>> - all in ASCII? Terminated by \0. No need for flags, no need
> >>> for endianness crap, no need to worry about field becoming too
> >>> narrow...
> 
> There's just that little overflow problem to worry about,

Ummm:

-- stuff ASCII digits into u64 (or u32, or whatever)
-- if (still more digits)
   -- printk("partition too big to mount!\n")
   -- return error

How hard is that?

> trailing garbage,

Don't write garbage into your partition table.

> encouragement of assumptions about the maximum size...
> is that a %d or a %llu or what?

See above.  Use leading '-' for negative numbers.  ASCII has no
2's complement ambiguity issues.

miket
