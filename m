Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJGSI0>; Mon, 7 Oct 2002 14:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJGSI0>; Mon, 7 Oct 2002 14:08:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261661AbSJGSIZ>;
	Mon, 7 Oct 2002 14:08:25 -0400
Date: Mon, 7 Oct 2002 19:14:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <efault@gmx.de>, Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: bcopy()
Message-ID: <20021007191404.N18545@parcelfarce.linux.theplanet.co.uk>
References: <5.1.0.14.2.20021007195409.00b54a98@pop.gmx.net> <Pine.LNX.4.33.0210071105350.21165-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210071105350.21165-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 07, 2002 at 11:08:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:08:19AM -0700, Linus Torvalds wrote:
> So I'd much rather see the XFS etc code moved away from bcopy() first,
> because that's the _real_ cleanup. The library code isn't all that ugly in
> comparison.

The only user of bcopy() in the entire kernel which wasn't _already_
using a #define was in arch/ia64/sn/io/module.c, and i fixed that as
part of the patch.

-- 
Revolutions do not require corporate support.
