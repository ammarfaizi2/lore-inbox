Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKPGfj>; Thu, 16 Nov 2000 01:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPGf3>; Thu, 16 Nov 2000 01:35:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20239 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129245AbQKPGfN> convert rfc822-to-8bit; Thu, 16 Nov 2000 01:35:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Modprobe local root exploit
Date: 15 Nov 2000 22:04:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uvtdv$c3q$1@cesium.transmeta.com>
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de> <E13wHVO-0007VB-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id WAA07585
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13wHVO-0007VB-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> >     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> > 
> >     Francis> Just in case... Some modules have uppercase letters too :)
> > 
> > That's what the &0xdf is intended for...
> 
> That looks wrong for UTF8 which is technically what the kernel uses 8)
> 

No, it's correct, actually, but probably not what you want.  It will
include all letters [A-Za-z], but if a module named "ärlig"...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
