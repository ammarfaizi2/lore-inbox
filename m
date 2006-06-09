Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWFIUK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWFIUK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWFIUK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:10:57 -0400
Received: from web26904.mail.ukl.yahoo.com ([217.146.176.93]:16245 "HELO
	web26904.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030477AbWFIUKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:10:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tEW+gRF2TB2aMw9sB8dM1At5j+qF1Zaz6ZZM5uvX4Z4PPOlasRzy+ZpHw0gs+jHSWnv7CnpL9eRPGzM+zV95ZM/SQAtAFGRHh+xajoMLynaGzvvAHWuDomQkp33Y6AS3kTBBCb0NPps+FDZPT89iJ0hQSEpAgTQB2AXQGrYtWw8=  ;
Message-ID: <20060609201054.13944.qmail@web26904.mail.ukl.yahoo.com>
Date: Fri, 9 Jun 2006 22:10:54 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: RE : Re: [RFC] ATA host-protected area (HPA) device mapper?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org
In-Reply-To: <1149873734.22124.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >  Gujin is assuming that your hard disk are accessible by the documented ATA ide
> >  system, and some (or all?) IDE SATA interface have (volumtary?) broken
> >  implementation: they are not IDE register compatible.
> 
> SFF was never a formal standard, and ST-506 was a random vendor
> interface copying exercise that caught on. ACPI permits the firmware to
> provide ATA taskfiles but afaik not the boot loader unfortunately.

  I can understand that 10+ years old interface can be updated, or even redesigned,
 but when you buy the hardware you should be aware that it is not at all compatible
 (maybe some chipset only), so you can decide what to buy. If the spec of your
 hardware say that it is 100% compatible and the chipset do not implement its spec,
 you have a problem.
  It is mainly to increase the bandwidth of the pipe linking the hard disk to the
 memory, but anyway the hard disk cannot reach this bandwidth for ATA anyway (unless
 reading it own memory cache).
  And there is still the current hardware ATA + ATA disk to manage.

> A lot of newer SATA hardware uses a common standard defined interface
> called AHCI, and it appears most vendors are migrating in the direction
> of using AHCI. If so then we are in the same kind of flux as the VLB
> world before SFF and PCI settled the standard interfaces down for a
> while.
> Don't see how your HPA code protects versus password locking however. If
> I hack the OS I write a new boot block which locks the disk then reboot
> into it. By the time you go for your floppy its too late.

 If someone has write access to the MBR and the power supply, well he can destroy
 the system in so many ways. Note that if the hard disk has an IDE password
 that you know and that the disk is frozzen, your new boot block has to enter
 the known-by-you password first...
 Gujin cannot set an IDE password (use other utilities for that), but will ask
 you the password of locked hard disks (after keyboard mapping/language recognition)
 before probing them for partiton.

> If thats not the case I'm most interested how you set it up to avoid
> this.
> 
> Alan
> 

  Etienne.

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
