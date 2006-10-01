Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWJAQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWJAQps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJAQps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:45:48 -0400
Received: from s0006.shadowconnect.net ([213.202.216.60]:13572 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751260AbWJAQpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:45:47 -0400
Message-ID: <451FF0B1.9040706@shadowconnect.com>
Date: Sun, 01 Oct 2006 18:45:37 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2O: mark i2o_config broken on 64-bit
References: <20061001155636.GA6836@havoc.gtf.org> <adalko0xbgt.fsf@cisco.com>
In-Reply-To: <adalko0xbgt.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Roland Dreier wrote:
>  > -			//TODO 64bit fix
>  > +			//FIXME: broken on 64-bit
>  >  			sg[i].addr_bus = (u32) p->phys;
> This looks worse than just broken on 64 bit.  I didn't even attempt to
> understand what's going on here, but would this even work on 32 bit
> systems that have physical addresses above 4 gigs (eg i386 with PAE)?

It's a kind of user-space driver :-D This part of the driver just send 
the data generated in the user-space program 1:1 to the controller. It 
works on 64-bit, but i doubt it works with 64-bit DMA addresses. This 
part of the code was copied from "drivers/scsi/dpt_i2o.c". I already 
tried to replace it with an IMHO nicer sysfs solution, but because this 
also required an "workaround" it was dropped again.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
