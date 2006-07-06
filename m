Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWGFLuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWGFLuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWGFLuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:50:44 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:10438 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965179AbWGFLun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:50:43 -0400
Date: Thu, 6 Jul 2006 13:50:27 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706135027.140c6f8c@cad-250-152.norway.atmel.com>
In-Reply-To: <1152185425.24611.140.camel@localhost.localdomain>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<1152185425.24611.140.camel@localhost.localdomain>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 13:30:25 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2006-07-06 at 12:03 +0200, Haavard Skinnemoen wrote: 
> > > Looks pretty sane from a quick scan.
> > > 
> > > - request_irq() can use GFP_KERNEL?
> > 
> > Probably, but the genirq implementation also uses GFP_ATOMIC.
> 
> Is there a good reason, why AVR32 needs its own interrupt handling
> implementation ?

No, not really. At least not after the genirq stuff went in. I used to
be a bit concerned about the generic irq code being too heavyweight,
but I think handle_simple_irq() might be just what we need for
chip-internal interrupt handling.

> >From a short glance there's nothing which can not be handled by the
> generic code. Also there are a couple of things missing -e.g.
> recursive enable/disable_irq() handling. 

You're probably right. I'll see if I can get it converted to genirq
one of the next days.

Håvard
