Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWIqo>; Thu, 23 Nov 2000 03:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129640AbQKWIqd>; Thu, 23 Nov 2000 03:46:33 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:63666
        "EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
        with ESMTP id <S129507AbQKWIq2>; Thu, 23 Nov 2000 03:46:28 -0500
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Thu, 23 Nov 2000 09:16:20 +0100 (MET)
Message-Id: <200011230816.JAA03702@duna207.danubius>
To: linux-kernel@vger.kernel.org
Subject: no floppy caching in 2.4.0-test11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems as if recent kernles don't cache floppy reads. Is this
intentional? I haven't tried it for a long time, so I have no idea
when this behavior changed.

Miklos


bcica:~> time dd if=/dev/fd0 of=/dev/null bs=2048 count=100
100+0 records in
100+0 records out
0.000u 0.000s 0:07.59 0.0%      0+0k 0+0io 97pf+0w
bcica:~> time dd if=/dev/fd0 of=/dev/null bs=2048 count=100
100+0 records in
100+0 records out
0.000u 0.010s 0:07.10 0.1%      0+0k 0+0io 97pf+0w
bcica:~> time dd if=/dev/fd0 of=/dev/null bs=2048 count=100
100+0 records in
100+0 records out
0.000u 0.020s 0:07.21 0.2%      0+0k 0+0io 97pf+0w

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
