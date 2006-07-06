Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWGFL1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGFL1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGFL1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:27:48 -0400
Received: from www.tglx.de ([213.239.205.147]:10883 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932356AbWGFL1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:27:47 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060706120319.26b35798@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <20060706021906.1af7ffa3.akpm@osdl.org>
	 <20060706120319.26b35798@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 13:30:25 +0200
Message-Id: <1152185425.24611.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 12:03 +0200, Haavard Skinnemoen wrote: 
> > Looks pretty sane from a quick scan.
> > 
> > - request_irq() can use GFP_KERNEL?
> 
> Probably, but the genirq implementation also uses GFP_ATOMIC.

Is there a good reason, why AVR32 needs its own interrupt handling
implementation ?

>From a short glance there's nothing which can not be handled by the
generic code. Also there are a couple of things missing -e.g. recursive
enable/disable_irq() handling. 

	tglx



