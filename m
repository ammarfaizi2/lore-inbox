Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLBBe3>; Sun, 1 Dec 2002 20:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLBBe3>; Sun, 1 Dec 2002 20:34:29 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:42639 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S263143AbSLBBe2>;
	Sun, 1 Dec 2002 20:34:28 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] generic HDLC update for 2.4.21-pre
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 02 Dec 2002 02:41:27 +0100
Message-ID: <m3el91jiyg.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan, Marcelo:

I've uploaded the HDLC update discussed here to:
ftp://hq.pm.waw.pl/pub/linux/hdlc/current/hdlc-2.4.20.patch.gz

This patch is essentially a downport from current 2.5 kernel line, which
means quite a big rewrite and a binary incompatibility of userspace
utility "sethdlc".

There seem to be an agreement that this patch should be applied to 2.4,
despite the compatibility problem. Most users are already using the
updated version anyway (my own hw drivers only support 2 older ISA cards,
while manufacturers of newer cards have drivers working only with
the newer code).

The new code isn't really that new, it has been in use for over a year.

This patch doesn't change anything outside "generic HDLC" area
(except that it adds a new SIOCWANDEV net device ioctl, which is used
instead of various SIOCDEVPRIVATEs, but it's a trivial change).

Please apply to 2.4. Thanks.


Francois: I hope the dscc4 driver from 2.5 is ok. It compiles cleanly
(not counting the __setup warning if built as a module), but I have no hw
to test it. I'd be glad if you check it's working correctly. Thanks.
-- 
Krzysztof Halasa
Network Administrator
