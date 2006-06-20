Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWFTH2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWFTH2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWFTH2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:28:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965120AbWFTH2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:28:15 -0400
Date: Tue, 20 Jun 2006 00:28:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: heiko.carstens@de.ibm.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [patch 8/8] lock validator: add s390 to supported options
Message-Id: <20060620002802.c2184c0b.akpm@osdl.org>
In-Reply-To: <1150787267.2891.147.camel@laptopd505.fenrus.org>
References: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com>
	<20060619150547.0b6213b1.akpm@osdl.org>
	<1150787267.2891.147.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 09:07:47 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Mon, 2006-06-19 at 15:05 -0700, Andrew Morton wrote:
> > Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > >
> > >  config DEBUG_SPINLOCK_ALLOC
> > >  	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
> > > -	depends on DEBUG_SPINLOCK && X86
> > > +	depends on DEBUG_SPINLOCK && (X86 || S390)
> > 
> > Can we please stomp this out before it starts to look like
> > CONFIG_FRAME_POINTER?
> 
> why is this even an arch option ?

I made it thus, because it failed to compile on powerpc.
