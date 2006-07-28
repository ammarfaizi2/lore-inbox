Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWG1NCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWG1NCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWG1NCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:02:12 -0400
Received: from web36710.mail.mud.yahoo.com ([209.191.85.44]:28296 "HELO
	web36710.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030229AbWG1NCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:02:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ar5gsoPDFsinP3dqEl227SmmdVFYiXffCt9jHVq9fhaONcOA/o3sn0Uln3r/KXFT1Xhu2V1a/mLca3aGuL0AzRZtijUaivgd9XMq81rl5Ux38hS96PLp7ZR2+einLzd1pbu60bc8cySWtxikrCMzGDxUFEW1zuCDT2evElq9fT0=  ;
Message-ID: <20060728130211.63649.qmail@web36710.mail.mud.yahoo.com>
Date: Fri, 28 Jul 2006 06:02:11 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060728114645.GC16961@pazke.donpac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exact condition is (irq_status!=0 &&
irq_status!=0xffffffff). I think it is not any better
that what I have.

--- Andrey Panin <pazke@donpac.ru> wrote:

> On 208, 07 27, 2006 at 08:34:06PM -0700, Alex Dubov
> wrote:
> 
> What this strange line (in tifm_7xx1_isr function)
> is supposed to do:
> 
>         if(irq_status && (~irq_status))
> 
> check for nonzero irq_status in most obfuscated way
> ?
> Please replace it with something readable.
> 
> > I would like to announce the availability of the
> > driver for TI FlashMedia flash card readers.
> Currently
> > supported pci ids:
> > 1. 104c:8033.3
> > 2. 104c:803b.2
> > 
> > Device with id 8033 also features sdhci interface
> (as
> > subfunction 4). However, sdhci is disabled on many
> > laptops (notably Acer's), while FlashMedia
> interface
> > is available.
> > 
> > The driver is called tifmxx and available from:
> > http://developer.berlios.de/projects/tifmxx/
> > 
> > Only mmc/sd cards are supported at present, via
> mmc
> > subsystem. Provisions for other card types (Sony
> MS,
> > xD and such) are in place, but no support is
> available
> > due to lack of hardware and interest.
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> > http://mail.yahoo.com 
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> Andrey Panin		| Linux and UNIX system administrator
> pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
