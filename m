Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTCEOuo>; Wed, 5 Mar 2003 09:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTCEOuo>; Wed, 5 Mar 2003 09:50:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60690 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265132AbTCEOun>; Wed, 5 Mar 2003 09:50:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Unable to boot a raw kernel image :??
Date: 5 Mar 2003 07:00:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b453er$qo7$1@cesium.transmeta.com>
References: <20021129132126.GA102@DervishD> <3DF08DD0.BA70DA62@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3DF08DD0.BA70DA62@gmx.de>
By author:    Edgar Toernig <froese@gmx.de>
In newsgroup: linux.dev.kernel
> 
> I had this problem a while ago.  It turned out to be a (widespread)
> BIOS bug triggered be the disk-size probe of the kernel's boot loader.
> 

It's not a bug, really.  The fact of the matter is that the disk
geometry probe in bootsect.S pretty much only works for legacy
floppies... no IDE floppies, no USB floppies, no virtual floppies.

That, and the 1 MB limitation, is the reason it either needs to get
nuked or get some massive surgery.  I am currently trying to get Linus
to accept a patch to put it out of its misery.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
