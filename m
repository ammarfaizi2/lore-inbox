Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbSJGPQ4>; Mon, 7 Oct 2002 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263095AbSJGPQ4>; Mon, 7 Oct 2002 11:16:56 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:16145 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263092AbSJGPQy>; Mon, 7 Oct 2002 11:16:54 -0400
Date: Mon, 7 Oct 2002 16:22:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: remove bcopy()
Message-ID: <20021007162227.A15313@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20021007152510.K18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007152510.K18545@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Oct 07, 2002 at 03:25:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:25:10PM +0100, Matthew Wilcox wrote:
> 
> There are very few places in the kernel which use bcopy() as of 2.5.40,
> and every single one of them #defines it to memcpy() [some argue this
> should be memmove().  i'm not terribly concerned].  There's also no
> declaration of the bcopy() function in the kernel headers.  In light of
> this, would anyone object to a patch removing the definitions of bcopy
> from lib/string.c and arch/*/lib?

Please do.  But please let the defines in XFS in place - this
way the source stais compatible to the IRIX version.

