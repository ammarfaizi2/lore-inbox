Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbSJGSNU>; Mon, 7 Oct 2002 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbSJGSNU>; Mon, 7 Oct 2002 14:13:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35600 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262634AbSJGSNT>; Mon, 7 Oct 2002 14:13:19 -0400
Date: Mon, 7 Oct 2002 11:17:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <willy@debian.org>
cc: Mike Galbraith <efault@gmx.de>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: bcopy()
In-Reply-To: <20021007191404.N18545@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.33.0210071116380.1356-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Matthew Wilcox wrote:
> 
> The only user of bcopy() in the entire kernel which wasn't _already_
> using a #define was in arch/ia64/sn/io/module.c, and i fixed that as
> part of the patch.

The thing is, if the choice is between a #define and a bcopy() function,
I'd rather take the function and get rid of the #define instead.

Are there any XFS people that can be shamed into doing a 
search-and-replace and do this right?

		Linus

