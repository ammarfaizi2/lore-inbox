Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRIDQJm>; Tue, 4 Sep 2001 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRIDQJc>; Tue, 4 Sep 2001 12:09:32 -0400
Received: from otter.mbay.net ([206.40.79.2]:29456 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S269796AbRIDQJS>;
	Tue, 4 Sep 2001 12:09:18 -0400
Date: Tue, 4 Sep 2001 09:09:08 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
cc: Jeff Mahoney <jeffm@suse.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
In-Reply-To: <OF263FB8E3.75D4DAB3-ONC1256ABD.004F349C@de.ibm.com>
Message-ID: <Pine.LNX.4.20.0109040907260.25139-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Ulrich Weigand wrote:

> 
> Jeff Mahoney wrote:
> 
> >    Are the S/390 asm/unaligned.h versions broken, or is the ReiserFS code
> doing
> >    something not planned for? It's a 16-bit member, at a 16-bit alignment
> >    in the structure.  The structure itself need not be aligned in any
> >    particular manner as it is read directly from disk, and is a packed
> structure.
> 
> The S/390 unaligned.h macros are just direct assignments because the
> S/390 hardware normally *allows* unaligned accesses just fine.
> 
> It is only *atomic* accesses (those implemented using the S/390
> compare-and-swap instruction) that need to be word aligned; this includes
> the atomic bit operations that reiserfs appears to be using.

Aren't their some other "must align" instructions like CVB? Or have they
all been relaxed...

john

