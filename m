Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSHLKPd>; Mon, 12 Aug 2002 06:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHLKPd>; Mon, 12 Aug 2002 06:15:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317755AbSHLKPc>;
	Mon, 12 Aug 2002 06:15:32 -0400
Date: Mon, 12 Aug 2002 14:17:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029148468.16421.139.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208121415550.4996-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Alan Cox wrote:

> That would get extremely messy when handing interrupts arriving while in
> an APM bios call (which is required on many laptops). I believe the 0x40
> = 0x40 assumption is identical across windows, buggy apm, buggy bios32,
> buggy edd, buggy .. (you get the picture)

ugh, we do Linux interrupts while in the APM BIOS?

in any case, it should be possible to create a 'minimal GDT' for the APM
BIOS [so that Linux interrupt handling is still possible] - to isolate it
from Linux as much as possible. But i agree that this gets messy ...

	Ingo

