Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTBJUua>; Mon, 10 Feb 2003 15:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBJUua>; Mon, 10 Feb 2003 15:50:30 -0500
Received: from mail.buerotec.de ([217.89.50.162]:2821 "EHLO mail.buerotec.de")
	by vger.kernel.org with ESMTP id <S262446AbTBJUu3>;
	Mon, 10 Feb 2003 15:50:29 -0500
Date: Mon, 10 Feb 2003 21:57:52 +0100
From: Kay Sievers <lkml@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
Message-ID: <20030210205752.GB16226@vrfy.org>
References: <20030210203702.GA16226@vrfy.org> <Pine.LNX.4.44.0302101448280.3320-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302101448280.3320-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 02:49:36PM -0600, Kai Germaschewski wrote:
> On Mon, 10 Feb 2003, Kay Sievers wrote:
> >   ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
> 
> Interesting. Thanks for testing CONFIG_MODVERSIONS. I cannot reproduce it
> here, unfortunately (not even with the same .config). What does
> arch/i386/kernel/.tmp_time.ver look like?

pim:/usr/src/linux-2.5.60# cat arch/i386/kernel/.tmp_time.ver
__crc_i = 0x_lock ;     ac2d2492
pim:/usr/src/linux-2.5.60# 

pim:/usr/src/linux-2.5.60# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.2/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--disable-__cxa_atexit --enable-java-gc=boehm --enable-objc-gc
i386-linux
Thread model: posix
gcc version 3.2.2

pim:/usr/src/linux-2.5.60# ld -v
GNU ld version 2.13.90.0.18 20030121 Debian GNU/Linux

Kay

