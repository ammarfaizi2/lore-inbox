Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWGFMH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWGFMH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGFMH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:07:29 -0400
Received: from www.osadl.org ([213.239.205.134]:65155 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932156AbWGFMH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:07:28 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060706135027.140c6f8c@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <20060706021906.1af7ffa3.akpm@osdl.org>
	 <20060706120319.26b35798@cad-250-152.norway.atmel.com>
	 <1152185425.24611.140.camel@localhost.localdomain>
	 <20060706135027.140c6f8c@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:10:07 +0200
Message-Id: <1152187808.24611.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 13:50 +0200, Haavard Skinnemoen wrote:
> On Thu, 06 Jul 2006 13:30:25 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 2006-07-06 at 12:03 +0200, Haavard Skinnemoen wrote: 
> > > > Looks pretty sane from a quick scan.
> > > > 
> > > > - request_irq() can use GFP_KERNEL?
> > > 
> > > Probably, but the genirq implementation also uses GFP_ATOMIC.
> > 
> > Is there a good reason, why AVR32 needs its own interrupt handling
> > implementation ?
> 
> No, not really. At least not after the genirq stuff went in. I used to
> be a bit concerned about the generic irq code being too heavyweight,
> but I think handle_simple_irq() might be just what we need for
> chip-internal interrupt handling.
> 
> > >From a short glance there's nothing which can not be handled by the
> > generic code. Also there are a couple of things missing -e.g.
> > recursive enable/disable_irq() handling. 
> 
> You're probably right. I'll see if I can get it converted to genirq
> one of the next days.

Good. If there are any questions or things you find missing, don't
hesitate to ask.

	tglx


