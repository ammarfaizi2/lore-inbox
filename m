Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLMLHo>; Wed, 13 Dec 2000 06:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLMLHY>; Wed, 13 Dec 2000 06:07:24 -0500
Received: from david.siemens.de ([192.35.17.14]:34242 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S129415AbQLMLHP>;
	Wed, 13 Dec 2000 06:07:15 -0500
X-Envelope-Sender-Is: tjeerd.mulder@fujitsu-siemens.com (at relayer david.siemens.de)
Message-ID: <3A3750C3.973CF9FD@fujitsu-siemens.com>
Date: Wed, 13 Dec 2000 11:34:43 +0100
From: Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
X-Mailer: Mozilla 4.05 [de] (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: National Semiconductor DP83815 ethernet driver?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please, don't even consider using the NSC dp83815 driver.

I too received this NSC (TeamF1) driver, hacked on it, fed the modifications
to NSC and this TeamF1.
Some time October I received the latest and greatest version from NSC
and found no trace of my changes, but some "Shaun Savage" hacked on it
and ported the buggy 2.2 version to 2.4. 

He found the tbusy flag gone so implemented this:

if (chip_out_of_descriptors) {
	drop_packet();
	stats->tx_dropped++;
}

netif_stop_queue(), what's that ???

I must admit that I did not look any further at this driver ...

Please try the driver in 2.4.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
