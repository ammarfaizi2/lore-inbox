Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTBTNaR>; Thu, 20 Feb 2003 08:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTBTNaQ>; Thu, 20 Feb 2003 08:30:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37506
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265400AbTBTNaQ>; Thu, 20 Feb 2003 08:30:16 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0302201415070.18109-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302201415070.18109-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045752038.3790.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 14:40:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 13:16, Geert Uytterhoeven wrote:
> On Tue, 18 Feb 2003, Alan Cox wrote:
> > -static void ide_outb (u8 value, ide_ioreg_t port)
> > +static void ide_outb (u8 addr, unsigned long port)
> 
> > -static void ide_outw (u16 value, ide_ioreg_t port)
> > +static void ide_outw (u16 addr, unsigned long port)
> 
> > -static void ide_outl (u32 value, ide_ioreg_t port)
> > +static void ide_outl (u32 addr, unsigned long port)
> 
> The first parameter should be called `value', not `addr'.


Yep. That change missed the base 2.4 tree so it rippled back
into 2.5. I'll fix it up at some point

