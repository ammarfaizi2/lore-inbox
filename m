Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbUKDPgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUKDPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbUKDPgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:36:16 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:18953 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262263AbUKDPgC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:36:02 -0500
Date: Thu, 4 Nov 2004 16:30:23 +0100 (CET)
To: degger@fhm.edu
Subject: Re: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <JwLGVeAP.1099582223.3370560.khali@gcu.info>
In-Reply-To: <B55F1204-2E70-11D9-BF00-000A958E35DC@fhm.edu>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Feel free to submit a dump (using i2cdump) of that unknown chip if you
> > want me to comment on it.
>
> egger@ulli:~$ sudo i2cdetect -l
> i2c-2   unknown         SMBus2 AMD8111 adapter at c400
> (...)
> egger@ulli:~$ sudo i2cdetect 2
> (...)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

According to the SMBus 2.0 specs [1], page 59, address 0x08 represents
the SMBus host itself, so it's not a client. This SMBus is empty.

> Anything else I can try?

No, this bus is simply empty, no need to look any further. For some
reason these AMD chipsets have two different SMBus. Most motherboard
manufacturers only use the first one.

Jean

[1] http://www.smbus.org/specs/smbus20.pdf
