Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSG1SuK>; Sun, 28 Jul 2002 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSG1SuK>; Sun, 28 Jul 2002 14:50:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58101 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317182AbSG1SuI>; Sun, 28 Jul 2002 14:50:08 -0400
Subject: Re: [OOPS] Re: PATCH: 2.5.29 Fix pnpbios
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathaniel <wfilardo@fuse.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D4378B2.1000200@fuse.net>
References: <E17YcDa-0002Mf-00@the-village.bc.nu> 
	<3D4378B2.1000200@fuse.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 21:08:52 +0100
Message-Id: <1027886932.842.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 05:53, Nathaniel wrote:
> Alan Cox wrote:
> > This should do the trick for pnpbios - we load the initial gdt into each
> > gdt, and we load the parameters into the gdt of the cpu making the call 
> > relying on the spinlock to avoid bouncing cpu due to pre-empt
> 
> I get the following (hand-transcribed) oops at bootup on a patched (see below) 2.5.29 on a UP Athlon 900Mhz system with an ASUS K7V (unsure about the V) motherboard.

It blew up making the initial PnPBIOS call. That certainly smells of
incorrectly set up GDT segments. I'll take a look

