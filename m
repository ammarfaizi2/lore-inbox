Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbRAaIOH>; Wed, 31 Jan 2001 03:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130921AbRAaIN5>; Wed, 31 Jan 2001 03:13:57 -0500
Received: from mail.linux.com ([198.186.203.59]:13319 "EHLO mail.i.linux.com")
	by vger.kernel.org with ESMTP id <S130367AbRAaINr>;
	Wed, 31 Jan 2001 03:13:47 -0500
Date: Wed, 31 Jan 2001 00:13:46 -0800
From: Andrew Prins <next@linux.com>
To: linux-kernel@vger.kernel.org
Subject: possible bug with adaptec aic-7896 and 2.4.x
Message-ID: <20010131001346.A29375@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux shiftq.linux.com 2.2.16 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in 2.4.0 and 2.4.1 on a pentium 3 with an onboard adaptec AIC-7896, i 
receive the following after it is detected:

scsi: aborting command due to timeout: pid 0, scsi0, channel 0, id 0
lun 0 Inquiry 00 00 00 ff 00

i get the error twice, then the box hangs. this occurs on both a single 
processor box and a dual processor box with a kernel without SMP support. 
on a dual processor box when SMP is compiled in, i receive a similar error:

scsi: aborting command due to timeout: pid 0, scsi0, channel 0, id 1 
lun 1 Inquiry 20 00 00 ff 00

but the box continues to boot fine.

the same hardware configuration in 2.2.15 works fine, and a similar hardware
configuration using a AIC-7895 instead of a AIC-7896 running 2.4.x works
fine.

any ideas?

thanks,

a

-- 
andrew prins (linux & diet coke advocate)
finger next@keys.boca.verio.net for pgp key.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
