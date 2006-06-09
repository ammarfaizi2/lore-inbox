Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWFIUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWFIUlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWFIUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:41:50 -0400
Received: from web26912.mail.ukl.yahoo.com ([217.146.177.79]:2671 "HELO
	web26912.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965157AbWFIUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:41:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QuJ+RXZwifLrTAlf1AHiMVWBaH0IUl+mMY0KazM1FKYAm5mMAFaVR5duksyfqd3TbKY0aEqY9dMzKSdSVI06/ufESLGDV1IbL/JywrHwGoqyvWEH2kkzdhHO4QDd6lJ/mVA9gVWruY8xQcuGm9owEFiZXsBVS8yfZjJIED9nWMY=  ;
Message-ID: <20060609204147.61760.qmail@web26912.mail.ukl.yahoo.com>
Date: Fri, 9 Jun 2006 22:41:47 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- XXXXXXXX wrote:
> It tends to be preferred around here to implement hardware features so 
> that hardware actually works, rather than to implement spec and blame 
> the hardware for failing to work to the spec.

 Well, the IDE hardware works, and conform to the ATA specs.
 Gujin is using those ATA command for quite a long time.
 I just have a problem with SATA chipset not being ATA1-7 compatible.

>  If, as you say, most BIOS 
> don't obey the spec, then implementing a spec that bears little 
> resemblance to actual behavior only helps the small number of 
> spec-compliant implementations.

  The main problem for BIOS manufacturer is the keyboard mapping
 recognition to enter the password. And there is no real point
 in freezing the password system of a locked drive.
  Gujin try to solve most of those problems, but because it is
 located on the hard disk itself limit the choice - it would be
 so nice to have a big enough BIOS FLASH and put Gujin there.
 Second best choice is having two hard disks (compact flash as
 first HD with compact flash <-> IDE adapter).

> >   The complete ATA specification is describing a register interface since ATA1,
> >  SATA chipsets should be software compatible, even if they add commands/interfaces:
> > http://www.sata-io.org/interopfaq.asp    say:
> >     Are there any known interoperability issues with SATA?
> >     One of the primary requirements of the SATA 1.0 specification was to
> >     maintain backward compatibility with existing operating system drivers
> >     to eliminate incompatibility issues.
> > 
> 
> Again with the "The spec says it works this way, so I can do it this 
> way."  I realize that you can be perfectly, legally, safe implementing 
> specified behavior, but it leaves you doing what you are doing here, 
> which is blaming the hardware for not living up to the specification. 

  Well the ATA specs are quite old, Gujin still work with the BIOS hard disk
 so still act as a bootloader, but it can not protecting you against a
 1 milisecond attack setting password.
 By the way the SATA specs are not free.

> It is generally the choice in the linux kernel to make the hardware 
> work, and ignore the specification where it is irrelevant to actual 
> functionality.  Read up on the SAS Transport Layer.

  Oh yes, Gujin has some strange code to make things work at the end,
 look for ATAPI stuff - I can and do ignore the specs to make the software
 work on real hardware.

  Cheers,
  Etienne.



__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
