Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbREUWZS>; Mon, 21 May 2001 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbREUWZI>; Mon, 21 May 2001 18:25:08 -0400
Received: from venus.Sun.COM ([192.9.25.5]:34508 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S262511AbREUWY7>;
	Mon, 21 May 2001 18:24:59 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <32f42309df.309df32f42@mysun.com>
Date: Tue, 22 May 2001 00:16:13 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: SMC-IRCC broken? 2.4.5-pre4 / -ac5+
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon!

Between pre3 and 4 (also somewhere in the middle of the -ac series)
the smc-ircc and/or irda subsystem went broken (at least for me).

The kernel stops while booting at:
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
SMC IrDA Controller found; IrCC version 2.0, port 0x118, dma=3, irq=3

The next message shuld be (in 2.4.4):
IrDA: Registered device irda0

It looks like it's some kind of loop, because the CPU fan starts running
at full speed.

This is on a Fujitsu-Siemens Lifebook S-4546

grep ^CONFIG_ .config | remove unimpotant lines:
CONFIG_IRDA=y
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_SMC_IRCC_FIR=y

gcc:
(gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81))

More info? just ask!

ps. I'm not on the list so please cc.

Regards
Pawel Worach

