Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVDUCRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVDUCRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDUCRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:17:18 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:37309 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261173AbVDUCRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:17:14 -0400
Date: Wed, 20 Apr 2005 21:17:13 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Bernhard Fischer <blist@aon.at>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Timur Tabi <timur.tabi@ammasso.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050421021713.GP999@kalmia.hozed.org>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <4263DBBF.9040801@ammasso.com> <1113840973.6274.84.camel@laptopd505.fenrus.org> <4263DF70.2060702@ammasso.com> <1113853240.6274.99.camel@laptopd505.fenrus.org> <20050418200711.GI15688@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20050418200711.GI15688@aon.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 10:07:12PM +0200, Bernhard Fischer wrote:
> On Mon, Apr 18, 2005 at 09:40:40PM +0200, Arjan van de Ven wrote:
> >On Mon, 2005-04-18 at 11:25 -0500, Timur Tabi wrote:
> >> Arjan van de Ven wrote:
> >> 
> >> > this is a myth; linux is free to move the page about in physical memory
> >> > even if it's mlock()ed!!
> darn, yes, this is true.
> I know people who introduced
> #define VM_RESERVED     0x00080000      /* Don't unmap it from swap_out
> */

Someone (aka Tospin, infinicon, and Amasso) should probably post a patch
adding '#define VM_REGISTERD 0x01000000', and some extensions to
something like 'madvise' to set pages to be registered.

My preference is said patch will also allow a way for the kernel to
reclaim registered memory from an application under memory pressure.
