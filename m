Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWEKWkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEKWkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWEKWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 18:40:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30473 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750798AbWEKWke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 18:40:34 -0400
Date: Thu, 11 May 2006 23:10:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards if IO space is not available
Message-ID: <20060511221059.GB28693@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Thomas Kleffel (maintech GmbH)" <tk@maintech.de>,
	linux-kernel@vger.kernel.org
References: <44629D10.80803@maintech.de> <1147362779.26130.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147362779.26130.45.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 04:52:58PM +0100, Alan Cox wrote:
> On Iau, 2006-05-11 at 04:10 +0200, Thomas Kleffel (maintech GmbH) wrote:
> > From: Thomas Kleffel <tk@maintech.de>
> > 
> > this patch enables ide_cs to access CF-cards via their common memory
> > rather than via their IO space.
> 
> One obvious problem. Your patch simply sets io_base to an ioremap value.
> The ide_cs code assumes port accesses (eg it does outb() on base + 2).
> While outb() may happen to work on ARM on ioremap returns it doesn't on
> most platforms.

And it doesn't even work on all ARM platforms.  I wish ARM folk would
recognise the difference between the different address spaces and stop
confusing them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
