Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131483AbQK2OLu>; Wed, 29 Nov 2000 09:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131497AbQK2OLl>; Wed, 29 Nov 2000 09:11:41 -0500
Received: from yara.IMSD.Uni-Mainz.DE ([134.93.144.68]:46604 "EHLO
        yara.imsd.uni-mainz.de") by vger.kernel.org with ESMTP
        id <S131483AbQK2OLd>; Wed, 29 Nov 2000 09:11:33 -0500
Date: Wed, 29 Nov 2000 14:40:28 +0100
From: Dominik Kubla <kubla@netz.klinik.uni-mainz.de>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: BUG: Moxa SmartIO driver does not register i/o regions
Message-ID: <20001129144028.B752@baobab.netz.klinik.uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Moxa Support,

While adapting the hinv_linux script (http://www.brownnut.com/hinv.htm)
i noticed that the mxser driver will only show up in /proc/interrupts,
but not in /proc/ioports.  Since it is highly unlikely that this driver
can access the board without any I/O ports i would consider this a bug.
(Moxa's msdiag tool does report the I/O ports, but i would prefer
that they are properly registered with the kernel...)

A quick check at the moxa driver shows that it also fails to register
the i/o region.

This bug is present both in v2.2 and v2.4.

As a further feature request: it would be nice if the moxa/mxser drivers
would support the /proc/tty-Interface.

Yours,
  Dominik Kubla
-- 
  Networking Group,  Hospital of Johannes Gutenberg-University
  Obere Zahlbacher Straﬂe 69, 55101 Mainz, Germany
  Tel: +49 (0)6131 17-7193   FAX: +49 (0)6131 17-477193
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
