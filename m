Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267887AbTAHTxi>; Wed, 8 Jan 2003 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbTAHTxi>; Wed, 8 Jan 2003 14:53:38 -0500
Received: from fmr02.intel.com ([192.55.52.25]:55758 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267887AbTAHTxZ> convert rfc822-to-8bit; Wed, 8 Jan 2003 14:53:25 -0500
content-class: urn:content-classes:message
Subject: RE: PCI code:  why need  outb (0x01, 0xCFB); ?
Date: Wed, 8 Jan 2003 11:10:33 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D0D1C@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI code:  why need  outb (0x01, 0xCFB); ?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK3R6r0/FZ+0SM5Edeo8gBQi2jWzAAATRpg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2003 19:10:34.0626 (UTC) FILETIME=[9EE77620:01C2B749]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally all accesses should be long (0xcf8/0xcfc) but x86 is byte addresseable and some chipsets do support byte accesses. 

We do not encourage use of byte accesses as it will not be supported in future platforms.

Thanks,
Jun

> -----Original Message-----
> From: H. Peter Anvin [mailto:hpa@zytor.com]
> Sent: Wednesday, January 08, 2003 10:53 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: PCI code: why need outb (0x01, 0xCFB); ?
> 
> Followup to:  <F87sTOHYNhMwqvbLaKL0001615a@hotmail.com>
> By author:    "fretre lewis" <fretre3618@hotmail.com>
> In newsgroup: linux.dev.kernel
> 
> > 1. which device is at port address 0xCFB?
> 
> Hopefully none.
> 
> > 2. what is meaning of the writing operation "outb (0x01, 0xCFB);" for
> THIS
> > device?, it'seem that PCI spec v2.0 not say anything about it?
> 
> It's trying to verify that the PCI northbridge does *NOT* respond to
> this (byte-wide) reference.
> 
> 	-hpa
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
