Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129548AbQKSGyJ>; Sun, 19 Nov 2000 01:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQKSGx7>; Sun, 19 Nov 2000 01:53:59 -0500
Received: from ppp079-pool1a.bham.zebra.net ([209.12.6.142]:17043 "HELO
	bliss.penguinpowered.com") by vger.kernel.org with SMTP
	id <S129548AbQKSGxt>; Sun, 19 Nov 2000 01:53:49 -0500
Date: Sun, 19 Nov 2000 00:17:50 -0600
From: "Forever shall I be." <zinx@microsoftisevil.com>
To: linux-kernel@vger.kernel.org
Subject: 7-order allocation failed
Message-ID: <20001119001750.A27537@bliss.zebra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint: 5746 73A1 2184 A27A 9EC0  EDCC E132 BCEF 921B 1558
X-PGP-Fingerprint: 1F 16 36 AF 28 80 62 20  05 18 A0 AF 47 95 0B 0E
X-GPG-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x921B1558
X-PGP-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0xEB936011
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting '__alloc_pages: 7-order allocation failed.' every time I
play something to my maestro card (using the maestro kernel module,
with dsps_order=2)..

I'm assuming the following code is to blame:

/* alloc as big a chunk as we can */
for (order = (dsps_order + (16-PAGE_SHIFT) + 1); order >= (dsps_order + 2 + 1); order--)
        if((rawbuf = (void *)__get_free_pages(GFP_KERNEL|GFP_DMA, order)))
                break;

Of course, it doesn't seem to cause any problems, but the warning is
really starting to get on my nerves...

-- 
Zinx Verituse                        (See headers for gpg/pgp key info)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
