Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754307AbWKHFdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbWKHFdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbWKHFdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:33:23 -0500
Received: from mail01.verismonetworks.com ([164.164.99.228]:47793 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1754306AbWKHFdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:33:22 -0500
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
From: Amol Lad <amol@verismonetworks.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1162945152.3625.2.camel@mulgrave.il.steeleye.com>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
	 <20061107125329.6dc4eb53.akpm@osdl.org>
	 <1162945152.3625.2.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 11:06:41 +0530
Message-Id: <1162964201.22062.178.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 09:19 +0900, James Bottomley wrote:
> On Tue, 2006-11-07 at 12:53 -0800, Andrew Morton wrote:
> 
> > hm.  How do we find out if this works?
> 
> I'm not sure anyone has this type of HW anymore.  It was the original
> SCSI chip for the old MCA based IBM PC.  I can dig through my hardware
> bins to see if I have a card, but I don't think so.

The only way I see is the code review. 

Most of the drivers using save_flags()/cli() interfaces are not in use
anymore (such as drivers/char/riscom8.c). There are two possibilities:
1. Remove such drivers from kernel
2. Fix them

This would mean we can remove cli()/sti()/save_flags() interfaces from
the kernel so that any new development does not uses them accidently

> 
> > If it _does_ work then we can now remove the Kconfig BROKEN_ON_SMP dependency
> > for this driver.
> 
> Theoretically, yes ... practically I don't think there was an SMP box
> produced with this chip.
> 
> James
> 
> 
> 

