Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268597AbRGYRYR>; Wed, 25 Jul 2001 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRGYRYH>; Wed, 25 Jul 2001 13:24:07 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:62218 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268597AbRGYRYB>; Wed, 25 Jul 2001 13:24:01 -0400
Date: Wed, 25 Jul 2001 19:23:53 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Artur Frysiak <wiget@pld.org.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why no modules for IDE chipset support?
In-Reply-To: <20010725190502.D29439@free.buy.pl>
Message-ID: <Pine.LNX.4.33.0107251916070.30648-100000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, Artur Frysiak wrote:

> On Wed, Jul 25, 2001 at 11:34:45AM -0500, Steven Walter wrote:
> > On Wed, Jul 25, 2001 at 11:31:25AM +0200, Uwe Bonnes wrote:
> > > Hallo,
> > > 
> > > why are the IDE chipset support driver not modularized? Is there anything
> > > fundamental that inhibits using these drivers as a modules?
> > 
> > They are availible as modules.  See "ATA/IDE/MFM/RLL support," which is
> > a tristate.  If you select that as a module, then all the chipsets you
> > select for support later will be compiled into one large module.
> > 
> > This is probably a bad idea, though, because if you compile IDE support
> > as a module, you will not be able to mount your root partition if it is
> > on an IDE disk.
> 
> This is not true. If you use initrd and load ide-mod, ide-probe-mod and
> ide-disk modules on it then you may mount yours root partition.
> For eg. we (PLD http://www.pld.org.pl/) have modular ide, scsi, reiserfs and
> ext2 (sic!). Small tool called geninitrd make initrd based on
> information from /etc/fstab, /etc/modules.conf and other configuration
> files.
> You may grab geninitrd from ftp://ftp.pld.org.pl/software/geninitrd/

Also for make very small initrd usefull use bsp. This is ~25KB statically
linked shell like program/processor with loading modules, initialize RAID
abilities for using only inside initrd.
BTW .. geninitrd is simple script :)

kloczek
PS. bsp is avalaible on ftp://ftp.pld.org.pl/software/bsp
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

