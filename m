Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSKFVFe>; Wed, 6 Nov 2002 16:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266103AbSKFVFe>; Wed, 6 Nov 2002 16:05:34 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:8209 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266100AbSKFVFe>; Wed, 6 Nov 2002 16:05:34 -0500
Date: Wed, 6 Nov 2002 22:11:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Stephen Cameron <steve.cameron@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 and make menuconfig weirdness
In-Reply-To: <20021106145150.A17824@zuul.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.44.0211062203320.13258-100000@serv>
References: <20021106145150.A17824@zuul.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Nov 2002, Stephen Cameron wrote:

> [root@zuul lx2546]# strace ./scripts/kconfig/mconf arch/i386/Kconfig
> 
> It seems to do TCGETS ioctl on every file it opens and gets ENOTTY,
> although it doesn't seem that this is necessarily a problem for it.

That's the flex generated scanner, I disabled that check here.

> It seems to read all of drivers/block/paride/Kconfig 
> (8192 + 4959 bytes == whole file) then it just quits?

Have you modified a Kconfig somewhere? Look for open strings, the scanner 
simply exits when it finds one (that's also fixed here).

bye, Roman

