Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280496AbRKELTE>; Mon, 5 Nov 2001 06:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280495AbRKELSx>; Mon, 5 Nov 2001 06:18:53 -0500
Received: from druid.if.uj.edu.pl ([149.156.64.221]:54276 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S280496AbRKELSn>; Mon, 5 Nov 2001 06:18:43 -0500
Date: Mon, 5 Nov 2001 12:18:12 +0100 (CET)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Hood <jdthood@mail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
In-Reply-To: <E160fNR-0004fu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111051215350.29021-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Alan Cox wrote:
> > Well here you have it...
> > W98SE reports the FDC at 0x3f0..0x3f5 and 0x3f7
>
> Its absolutely correct. 0x3f6 isnt floppy. That I suspect is what
> is causing the problem because it tries to grab 0x3f6 in Linux

No Linux doesn't grab 0x3f6 - what it grabs is 0x3f0-0x3f5 and 0x3f7 -
exactly as reported by w98 - however 0x3f0-0x3f1 have already been
reserved by the pnpbios code, since they are listed in the bios as
motherboard resources, while 0x3f2-03xf5 and 03xf7 are listed as floppy
-> the problem is that the floppy reserves ports that it does not need (in
fact it could skip reserving 0x3f3 also...)

