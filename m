Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKNXsP>; Tue, 14 Nov 2000 18:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKNXsF>; Tue, 14 Nov 2000 18:48:05 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:21768 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129045AbQKNXrt>; Tue, 14 Nov 2000 18:47:49 -0500
Date: Wed, 15 Nov 2000 00:17:19 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c 
 compilefailure
In-Reply-To: <3A11C445.EB65B9D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011150011200.5049-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Jeff Garzik wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Mon, 13 Nov 2000, Adam J. Richter wrote:
> > 
> > >       linux-2.4.0-test11-pre4/drivers/sound/yss225.c uses __initdata
> > > but does not include <linux/init.h>, so it could not compile.  I have
> > > attached below.
> > >
> > >       Note that I am a bit uncertain about the correctness of
> > > the __initdata prefix here in the first place.  Is yss225 a PCI
> > > device?  If so, a kernel that supports PCI hot plugging should
> > > be prepared to support the possibility of a hot pluggable yss225
> > > card being inserted after the module has already been initialized.
> > > Even if no CardBus or CompactPCI version of yss225 hardware exists
> > > yet, it will require less maintenance for PCI drivers to be prepared
> > > for this possibility from the outset (besides, is it possible to have a
> > > hot pluggable PCI bridge card that bridges to a regular PCI bus?).
> > 
> > Good question....
> 

I mean question about h-p PCI bridge card that bridges regular PCI bus...

> Please err on the conservative side -- IMHO you shouldn't mark a driver
> as hotpluggable (by using the '__dev' prefix) unless you know it is
> necessary.
> 
> Otherwise, you rob CONFIG_HOTPLUG people of some memory that could
> otherwise be freed at boot.  And the number of CONFIG_HOTPLUG people is
> not small, it includes not only the CardBus users but USB users too...
> 
> 	Jeff

I fully agree. That's why "hotplugging" drivers requires some more
effort then just adding __devfoo instead of __foo.
Jeff, have you read last coment in my mail?

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
