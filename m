Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRB1M3Q>; Wed, 28 Feb 2001 07:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130143AbRB1M25>; Wed, 28 Feb 2001 07:28:57 -0500
Received: from spider.nlr.nl ([137.17.80.200]:22319 "EHLO smtp-server.nlr.nl")
	by vger.kernel.org with ESMTP id <S130139AbRB1M2s>;
	Wed, 28 Feb 2001 07:28:48 -0500
Disclaimer: "The National Aerospace Laboratory NLR DOES NOT ACCEPT ANY FINANCIAL COMMITMENT derived from this message."
Message-ID: <3A9CEED6.C68D3FFD@nlr.nl>
Date: Wed, 28 Feb 2001 13:28:06 +0100
From: "Rob W. van Swol" <vanswol@nlr.nl>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: opl3sa2 won't load in kernel 2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I cannot find an answer to my problem. Sound was always working ok in
2.2.x and 2.4.1 kernels. But now the opl3sa2 module won't load anymore.
First I got the messages:

opl3sa2: No cards found
opl3sa2: 0 PnP card(s) found. 

The I added isapnp=0 to the options line in /etc/modules.conf and then I
get:

opl3sa2: Control I/O port 0x0 not free
                          ^^^
It seems that the io address is not correctly passed to the module?!


The relevant lines from /etc/modules.conf are:

alias sound-slot-0 opl3sa2
alias sound-service-0-0 opl3sa2
alias midi opl3
options opl3 io=0x388
options opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370
isapnp=0

Any idea???

Answer please with a CC to vanswol@nlr.nl
Regards,
Rob


_____________________________________________________________

Rob W. van Swol
National Aerospace Laboratory NLR       Tel. +31 527 248252
P.O. Box 153                            Fax  +31 527 248210
8300 AD Emmeloord                       E-Mail vanswol@nlr.nl
The Netherlands                         http://www.neonet.nl/

