Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUEVJdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUEVJdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265202AbUEVJdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:33:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:49316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265200AbUEVJdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:33:07 -0400
Date: Sat, 22 May 2004 02:32:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: hch@infradead.org
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-Id: <20040522023218.4d3e34e3.akpm@osdl.org>
In-Reply-To: <20040522092627.GA3432@infradead.org>
References: <20040522013636.61efef73.akpm@osdl.org>
	<20040522092627.GA3432@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch@infradead.org wrote:
>
> > +ipr-ppc64-depends.patch
> > 
> >  Make ipr.c depend on PPC
> 
> >> Makes ipr depend on CONFIG_PPC since this driver is unique to PPC hardware.
> >> 
> >> (It actually builds OK on x86, but it heavily uses anonymous unions, which
> >> breaks on gcc-2.95)
> 
> I use gcc-2.95 happily on ppc.  Better thing is to either fix it up not to
> use anonymous unions (which is a pitty because that feature helps making
> code more readable sometimes) or stick a

It uses a *ton* of anonymous unions.

> #if (__GNUC__ < 3)
> # error "This driver requires GCC 3.x"
> #endif

That breaks allfooconfig.

