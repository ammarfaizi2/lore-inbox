Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSLOXkB>; Sun, 15 Dec 2002 18:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSLOXkA>; Sun, 15 Dec 2002 18:40:00 -0500
Received: from harddata.com ([216.123.194.198]:19863 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S263276AbSLOXj7>;
	Sun, 15 Dec 2002 18:39:59 -0500
Date: Sun, 15 Dec 2002 16:47:53 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Mark Rutherford <mark@justirc.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20] via82cxxx goes postal and locks system, no full duplex(?)
Message-ID: <20021215164753.A30822@mail.harddata.com>
References: <3DFBFD61.1B367CD2@justirc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFBFD61.1B367CD2@justirc.net>; from mark@justirc.net on Sat, Dec 14, 2002 at 10:56:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 10:56:17PM -0500, Mark Rutherford wrote:
> I get a lot of errors, sometimes it locks the system, sometimes it does
> not.

I only can to add that I reported basically the same error sometimes
in October with respect to a kernel 2.4.18-17.8.0 used at that
time in Red Hat 8.0 distribution ( #76603 is a reference to Red Hat
bugzilla).  The only difference is that it works for me 100% of
time. :-)

Initially I ascribed it mistakenly to 'gnome-session', as it tries
to play something and locks my machine with an absolute reliability,
and without any traces in logs, but in later comments I corrected
that initial impression.  So far I do not know of any fixes but
sounds like the same "improvements" found its way into 2.4.20
kernel.

> 
> lspci info:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
....
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
> AC97 Audio Controller (rev 50)

I have here somewhat older hardware but in various aspects quite
similar

00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 21)
....
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 20)

This is a more complete picture of my PCI bus:

-[00]-+-00.0  VIA Technologies, Inc. VT8371 [KX133]
      +-01.0-[01]----00.0  Matrox Graphics, Inc. MGA G400 AGP
      +-07.0  VIA Technologies, Inc. VT82C686 [Apollo Super South]
      +-07.1  VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
      +-07.4  VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
      +-07.5  VIA Technologies, Inc. VT82C686 AC97 Audio Controller
      \-09.0-[02]--+-04.0  LSI Logic / Symbios Logic 53c895
                   \-05.0  Digital Equipment Corporation DECchip 21142/43


   Michal
