Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271715AbRH0Lzr>; Mon, 27 Aug 2001 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRH0Lzh>; Mon, 27 Aug 2001 07:55:37 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:45320 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S271704AbRH0Lz3>; Mon, 27 Aug 2001 07:55:29 -0400
Date: Mon, 27 Aug 2001 19:56:49 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: reiserfs can't replay on READ-ONLY partition
Message-ID: <Pine.LNX.4.33.0108271950300.852-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wanted to have Read-Only partition startup in /etc/fstab, but
reiserfs can't seems to replay the log if the partition is mounted
as read-only.

It gives a warning, and I don't think it's replaying the logs at all,

It seems so because if I mount, unmount the partition, repeatedly, it'll
keep warning and replaying the logs everytime. Only until I mount the
partition as read-write will the actual log be replayed ... this seems so,
as the moment I mount it as rw, unmount it, and mount it again, the replay
goes away and the partition get mounted very fast.

Thanks,
Jeff
[ jchua@fedex.com ]

