Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbSKEFKW>; Tue, 5 Nov 2002 00:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264765AbSKEFKV>; Tue, 5 Nov 2002 00:10:21 -0500
Received: from whitsun.whitsunday.net.au ([203.25.188.10]:55302 "EHLO
	mail1.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S263277AbSKEFKV> convert rfc822-to-8bit; Tue, 5 Nov 2002 00:10:21 -0500
From: John W Fort <johnf@whitsunday.net.au>
To: linux-kernel@vger.kernel.org
Subject: Patch-2.5.45-ac1  inia100 compile and run problems
Date: Tue, 05 Nov 2002 15:16:20 +1000
Message-ID: <etkesucpk7plmukbdvmsa4gbs2f4rng1oa@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attn: Alan Cox

Thank you for your work on the inia100 SCSI card, it not so much an orphan, but a street
kid that everyone thinks they can molest.

Trivial bits from 2.5.45-ac1 compile:
drivers/scsi/inia100.h:78: warning: `inia100_detect' declared `static' but never defined
drivers/scsi/inia100.h:79: warning: `inia100_release' declared `static' but never defined
drivers/scsi/inia100.h:80: warning: `inia100_queue' declared `static' but never defined
drivers/scsi/inia100.h:81: warning: `inia100_abort' declared `static' but never defined
drivers/scsi/inia100.h:82: warning: `inia100_device_reset' declared `static' but never defined
drivers/scsi/inia100.h:83: warning: `inia100_bus_reset' declared `static' but never defined

I was working on the last three of those but the rug was pulled from under me by someone
with a grander vision.

Anyhow, I ran two parallel Bonnies on both spindles on the same host/bus and got this:

Incorrect number of segments after building list
counted 17, received 16
req nr_sec 256, cur_nr_sec 8
end request: I/O error, dev 08:10 sector 6685776

and then hangs the bus.
Would it be because there is no 'eh_host_reset_handler'?

The first run both drives reported similar I/O errors.
Works fine with 'patch-2.5.45' from Linus.
How can I help?

cu  johnf

