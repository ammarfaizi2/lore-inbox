Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSLFQTj>; Fri, 6 Dec 2002 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLFQTj>; Fri, 6 Dec 2002 11:19:39 -0500
Received: from host194.steeleye.com ([66.206.164.34]:268 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263321AbSLFQTi>; Fri, 6 Dec 2002 11:19:38 -0500
Message-Id: <200212061626.gB6GQvl01748@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: david@gibson.dropbear.id.au, James.Bottomley@SteelEye.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Thu, 05 Dec 2002 23:14:16 PST." <200212060714.XAA06006@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 10:26:57 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 	I like your term DMA_CONSISTENT better than DMA_CONFORMANCE_CONSISTANT
> .  I think the word "conformance" in there does not reduce the time
> that it takes to figure out what the symbol means.  I don't think any
> other facility will want to use the terms DMA_{,IN}CONSISTENT, so I
> prefer that we go with the more medium sized symbol. 

I'm not so keen on this.  The idea of this parameter is not to tell the 
allocation routine what type of memory you would like, but to tell it what 
type of memory the driver can cope with.  I think for the inconsistent case, 
DMA_INCONSISTENT looks like the driver is requiring inconsistent memory, and 
expecting to get it.  I'm open to changing the "CONFORMANCE" part, but I'd 
like to name these parameters something that doesn't imply they're requesting 
a type of memory.

James


