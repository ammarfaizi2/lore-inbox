Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310660AbSC2SnJ>; Fri, 29 Mar 2002 13:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311024AbSC2SnA>; Fri, 29 Mar 2002 13:43:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54792 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310660AbSC2Smr>;
	Fri, 29 Mar 2002 13:42:47 -0500
Message-ID: <3CA4B547.AB359F0E@zip.com.au>
Date: Fri, 29 Mar 2002 10:41:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: davidm@hpl.hp.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <20020329160618.A25410@phoenix.infradead.org> <15524.40817.306204.292158@napali.hpl.hp.com> <3CA4A61A.A844E21B@zip.com.au> <20020329183457.A4087@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Fri, Mar 29, 2002 at 09:36:26AM -0800, Andrew Morton wrote:
> > Here's the diff.  Comments?
> 
> I don't see who having to independand declaration in the same kernel
> image are supposed to work..

It goes in lib/lib.a.  The linker will only pick up
the default version if the architecture doesn't
have its own dump_stack().

bust_spinlocks() has worked that way for quite some time.

> I think you really want some HAVE_ARCH_SHOW_STACK define to disable
> the generic version..

Yup.  But it's nice to be able to slot the default version
into lib.a.   In the bust_spinlocks case, architectures only
need to implement a version if they have special needs.

-
