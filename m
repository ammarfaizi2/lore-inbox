Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBVTyh>; Thu, 22 Feb 2001 14:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbRBVTy2>; Thu, 22 Feb 2001 14:54:28 -0500
Received: from alpha-gw.alpha-processor.com ([192.233.59.9]:63247 "HELO
	alpha-gw.alpha-processor.com") by vger.kernel.org with SMTP
	id <S129131AbRBVTyM>; Thu, 22 Feb 2001 14:54:12 -0500
Message-ID: <051DFF3BBA73D3119A5800A0C95BD021C8F389@barracuda.alpha-processor.com>
From: Christopher Chimelis <Christopher.Chimelis@api-networks.com>
To: "'f5ibh'" <f5ibh@db0bm.ampr.org>, xxh1@cdc.gov
Cc: linux-kernel@vger.kernel.org
Subject: RE: trouble with 2.4.2 just released
Date: Thu, 22 Feb 2001 14:53:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is with the version of ld you use. Some versions 
> are using 
> ld --oformat and other versions ld -oformat
> 
> This is quite a recent issue. So check the version of you linker.
> 
> You can solve the problem changing :
> ./arch/i386/boot/Makefile:      $(LD) -Ttext 0x0 -s -oformat 
> binary -o $@ $<
> to                                                  --oformat 
> 
> I think you hav not done any mistake, but the latest Debian 
> (unstable) version
> of ld seems not to be right.

The latest binutils in Debian potato will take either -oformat or --oformat,
IIRC.
The lastest binutils in Debian unstable (just uploaded yesterday) will only
take --oformat.  So, if you modify arch/i386/boot/Makefile to read:

	$(LD) -Ttext 0x0 -s --oformat binary -o $@ $< ...blah blah blah
you should be fine no matter which you're using...

Chris
(Debian binutils maintainer)
