Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbUK3SgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbUK3SgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUK3Sep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:34:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:55703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262256AbUK3Scm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:32:42 -0500
Date: Tue, 30 Nov 2004 10:32:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-Id: <20041130103218.513b8ce0.akpm@osdl.org>
In-Reply-To: <1101839110.2640.69.camel@laptop.fenrus.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101837994.2640.67.camel@laptop.fenrus.org>
	<20041130102105.21750596.akpm@osdl.org>
	<1101839110.2640.69.camel@laptop.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> > > > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
>  > > >   reclaim, but shouldn't.
>  > > 
>  > > 
>  > > what is the purpose of such a zone ??
>  > 
>  > For pages which have a physical address <4G.  I assume this was motivated
>  > by the lack of an IOMMU on ia32e?
> 
>  but there's the swiommu for those... so that can't be it
>  realistically....

"This helps mainly graphic drivers who really need a lot of memory below
the 4GB area.  Previous they could only use IOMMU+16MB GFP_DMA, which was
not enough memory."

>  Is there code using the zone GFP mask yet ??

Nope.
