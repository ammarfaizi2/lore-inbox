Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDWWLM>; Mon, 23 Apr 2001 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132387AbRDWWKx>; Mon, 23 Apr 2001 18:10:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18617 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132373AbRDWWKu>;
	Mon, 23 Apr 2001 18:10:50 -0400
Date: Mon, 23 Apr 2001 18:10:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Christoph Hellwig <hch@ns.caldera.de>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>, lm@bitmover.org,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010424000008.J719@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0104231807390.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Ingo Oeser wrote:

> We have this kind of stuff all over the place. If we allocate
> some small amount of memory and and need some small amount
> associated with this memory, there is no problem with a little
> waste.

Little? How about quarter of kilobyte per inode? sizeof(struct inode)
is nearly half-kilobyte. And icache can easily get to ~100000 elements.

> Waste is better than fragmentation. This is the lesson people
> learned from segments in the ia32.
> 
> Objects are easier to manage, if they are the same size.

So don't keep them in the same cache. Notice that quite a few systems
keep vnode separately from fs-specific data. For a very good reason.

								Al

