Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145057AbRA2Dk2>; Sun, 28 Jan 2001 22:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145072AbRA2DkT>; Sun, 28 Jan 2001 22:40:19 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:51147 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S145057AbRA2DkF>; Sun, 28 Jan 2001 22:40:05 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: Linux-2.4.1-pre11 / ll_rw_b watermark metric?
Date: Mon, 29 Jan 2001 04:43:52 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01012904435200.00697@SunWave1>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have pre11 running with Andrea's suggested fix.

        high_queued_sectors = total_ram / 3;
        low_queued_sectors = high_queued_sectors / 2;
        if (low_queued_sectors < 0)
                low_queued_sectors = total_ram / 2;
 
        /*
         * for big RAM machines (>= 384MB), use more for I/O
         */
        /*
        if (total_ram >= MB(384)) {
                high_queued_sectors = (total_ram * 4) / 5;
                low_queued_sectors = high_queued_sectors - MB(128);
        }
        */

Shouldn't it be clean for a 2.4.1 release?

-Dieter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
