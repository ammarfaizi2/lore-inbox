Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWJaBFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWJaBFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJaBFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:05:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422772AbWJaBFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:05:04 -0500
Date: Mon, 30 Oct 2006 17:04:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in
 create_irq
Message-Id: <20061030170445.1dedce1e.akpm@osdl.org>
In-Reply-To: <20061030090231.GA27146@elte.hu>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
	<20061030090231.GA27146@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 10:02:31 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> * Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> 
> > Fix warning
> > arch/i386/kernel/io_apic.c: In function `create_irq':
> > arch/i386/kernel/io_apic.c:2420: warning: 'vector' might be used uninitialized in this function
> 
> > @@ -2421,6 +2421,7 @@ int create_irq(void)
> >  	unsigned long flags;
> >  
> >  	irq = -ENOSPC;
> > +	vector = 0;
> 
> NAK - the code is fine, and this is fixed in Jeff's gcc-warnings tree 
> via annotation.

err, what gcc-warnings tree?

git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git#gccbug
just does lots of initialise-to-zero thingies, doesn't have any special
annotation and doesn't fix io_apic.c.

