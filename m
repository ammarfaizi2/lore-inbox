Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbTENRQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTENRQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:16:22 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:63503 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S262485AbTENRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:16:21 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D35F@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Rafal Bujnowski'" <bujnor@go2.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: RE: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Date: Wed, 14 May 2003 11:29:25 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0x5104 is a different can of worms from the other stuff you guys were
reporting.

5104 (status register = 0x51, error register 0x04) is the all-encompassing
"command abort" which is what the drive does any time you issue a command
with bad parameters, an invalid (immoral?) command, or some of the security
stuff out of sequence.  Most commonly it is seen attempting to enable
features on a drive that doesn't support them.

--eric

-----Original Message-----
From: Rafal Bujnowski [mailto:bujnor@go2.pl]
Sent: Wednesday, May 14, 2003 10:06 AM
To: linux-kernel
Cc: Maciej Soltysiak
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]


A Maciej Soltysiak <solt@dns.toxicfilms.tv> na to:

> Exactly like me.
> Someone suggested Bartlomiej Zolnierkiewicz's patch.
> Try this on for size. I haven't tested it yet, but please give it a
> shot.

Hello!

It doesn't work. I still get:

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }

I'll try Dany's hint.

rafal


-- 

[              Rafal Bujnowski ][ e-mail: bujnor<at>go2.pl            ]
[     http://www.bujnor.iq.pl/ ][ e-mail: bujnor<at>poczta.onet.pl    ]
[   ICQ: 85602025  GG: 4174829 ][ Jabber: bujnor@jabber.org           ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
