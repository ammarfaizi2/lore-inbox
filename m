Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSIDXr6>; Wed, 4 Sep 2002 19:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSIDXr6>; Wed, 4 Sep 2002 19:47:58 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:17676 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S316446AbSIDXr5> convert rfc822-to-8bit; Wed, 4 Sep 2002 19:47:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 16:52:30 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E012704DB@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUbOsUDhzqcwmJQK++tZgpRzS1SAAAD2RA
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 23:52:31.0411 (UTC) FILETIME=[220B8030:01C2546E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, September 04, 2002 4:45 PM
> To: Libershteyn, Vladimir
> Cc: Christoph Hellwig; linux-kernel@vger.kernel.org
> Subject: RE: Problem on a kernel driver(SuSE, SMP)
> 
> 
> On Wed, 2002-09-04 at 18:56, Libershteyn, Vladimir wrote:
> 
> > 	//
> > 	// sleep until data is ready
> > 	//
> > 	down_interruptible(&a->sem[enumerator]);
> 
> Suppose its interrupted. You dont check that and handle it..
> 

Agree, I'll fix it(thanks for noticing that), but it's not the point. 
The point is THIS INSTRUCTION HANGS. NO RETURN FROM IT.

> 
> > 	board_address = ((unsigned long *)((unsigned char 
> *)a->vaddr + OutputQueueFilled));
> > 	length = *board_address;
> 
> You can't poke around in memory directly either. Yes it works 
> on x86 but
> unless you use ioremap combined with readl and friends it 
> wont work they
> way you expect on ia64, x86-64, ...
> 

I did exactly what you've said. You have to understand, 
attached is a PART of the code. All the right initializations were made
prior to that and AGAIN, EVERYTHING WORKS FINE ON A RED HAT AND ON SUSE
NON_SMP

Regards,
Vlad
