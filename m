Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277046AbRJKXSy>; Thu, 11 Oct 2001 19:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277052AbRJKXSo>; Thu, 11 Oct 2001 19:18:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52182 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277046AbRJKXSe>;
	Thu, 11 Oct 2001 19:18:34 -0400
Date: Thu, 11 Oct 2001 19:19:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Ullrich <chris@chrullrich.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <20011012010846.A982@christian.chrullrich.de>
Message-ID: <Pine.GSO.4.21.0110111916070.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Oct 2001, Christian Ullrich wrote:

> * Alexander Viro wrote on Thursday, 2001-10-11:
> 
> > 	*Damn*.  grok_partitions() doesn't set the size of entire device
> > until it's done with check_partition().  Which means max_blocks() behaving
> > in all sorts of interesting ways, depending on phase of moon, etc.
> > 
> > 	Could you check if the following helps?
> 
> Yeah, that one did it.

Good.  What about other two cases?  I'm pretty sure that one of them
(sda9) is actually an invalid partition table and had worked only
by accident, but another may very well be fixed by that.

