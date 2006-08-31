Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHaTvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHaTvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWHaTvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:51:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52903 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932325AbWHaTvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:51:37 -0400
Subject: Re: [RFC][PATCH 2/9] conditionally define generic get_order()
	(ARCH_HAS_GET_ORDER)
From: Dave Hansen <haveblue@us.ibm.com>
To: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <1defaf580608311141j39aa87e5ldf80db1db54b2edf@mail.gmail.com>
References: <20060830221604.E7320C0F@localhost.localdomain>
	 <20060830221605.CFC342D7@localhost.localdomain>
	 <1defaf580608311141j39aa87e5ldf80db1db54b2edf@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 12:51:23 -0700
Message-Id: <1157053883.28577.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 20:41 +0200, Haavard Skinnemoen wrote:
> On 8/31/06, Dave Hansen <haveblue@us.ibm.com> wrote:
> > diff -puN mm/Kconfig~generic-get_order mm/Kconfig
> > --- threadalloc/mm/Kconfig~generic-get_order    2006-08-30 15:14:56.000000000 -0700
> > +++ threadalloc-dave/mm/Kconfig 2006-08-30 15:15:00.000000000 -0700
> > @@ -1,3 +1,7 @@
> > +config ARCH_HAVE_GET_ORDER
> > +       def_bool y
> > +       depends on IA64 || PPC32 || XTENSA
> > +
> 
> I have a feeling this has been discussed before, but wouldn't it be
> better to let each architecture define this in its own Kconfig?

As long as the conditions are simple, I think it would be nice to keep
it this way.  It makes it pretty obvious to tell what is going on from
_one_ place.  

> At some point, I have to add AVR32 to that list, and if one or more
> other architectures need to do the same, there will be rejects.

True, there will be rejects.  But, do you think they will actually take
more than a moment to merge?

-- Dave

