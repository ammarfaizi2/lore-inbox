Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBOQwC>; Thu, 15 Feb 2001 11:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBOQvx>; Thu, 15 Feb 2001 11:51:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129075AbRBOQvn>; Thu, 15 Feb 2001 11:51:43 -0500
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
To: eli.carter@inet.com (Eli Carter)
Date: Thu, 15 Feb 2001 16:49:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        root@chaos.analogic.com (Richard B. Johnson),
        tsbogend@alpha.franken.de, P.Missel@sbs-or.de (Peter Missel),
        linux-kernel@vger.kernel.org, eli.carter@inet.com (Eli Carter)
In-Reply-To: <3A8BFBF6.B99CFFF5@inet.com> from "Eli Carter" at Feb 15, 2001 09:55:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TRbL-0000AR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter pointed out that the contents of the CSR12-14 registers are
> initialized from the EEPROM, so reading the EEPROM is superfluous--we
> should just read the CSRs and not read the EEPROM.  I think he has a
> point, so I'll make that change and submit yet another patch pair.  

I'd rather keep the existing initialisation behaviour of using the eeprom
for 2.2. There are also some power management cases where I am not sure
the values are restored on the pcnet/pci.

For 2.2 conservatism is the key. For 2.4 by all means default to CSR12-14 and
print a warning if they dont match the eeprom value and we'll see what it
shows

> Alan, do you want me to put your inline version in <linux/etherdevice.h>
> while I'm at it, or what?

Sure
