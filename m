Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbREVS3T>; Tue, 22 May 2001 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbREVS3K>; Tue, 22 May 2001 14:29:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262711AbREVS24>; Tue, 22 May 2001 14:28:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Changes in Kernel
Date: 22 May 2001 11:28:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9eeb4s$m81$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105230000330.1601-100000@gdit.iiit.net> <E152GlV-0002Hh-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E152GlV-0002Hh-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> >   We are interested in making some changes to the linux kernel so that it
> > supports some indian type fonts on the console... so what are the special
> > things that we sould take care of so that our work would be included in
> > the kernel-distribution, and how do we proceed about getting it included
> > in the distributions?
> 
> Are there specific reasons you cannot just use the existing ioctls to load
> fonts ? The console driver already supports Klingon for example.
> 
> What are the issues - writing right - left ?
> 

Indian languages have complicated character/glyph mappings, similar to
Arabic but worse.

In general, these kinds of things is much better handled in user
space, similar to the way Asian languages are handled using the user
space console program "kon".  You would typically use the frame buffer
driver in the kernel and maintain the complicated state machines and
glyph sets in user space.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
