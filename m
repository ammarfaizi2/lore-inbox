Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQK3VCK>; Thu, 30 Nov 2000 16:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQK3VCA>; Thu, 30 Nov 2000 16:02:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64011 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129183AbQK3VB5>;
	Thu, 30 Nov 2000 16:01:57 -0500
Date: Thu, 30 Nov 2000 12:15:57 -0800
Message-Id: <200011302015.MAA06647@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: ben@zeus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001130191414.A13814@gruyere.muc.suse.de> (message from Andi
	Kleen on Thu, 30 Nov 2000 19:14:14 +0100)
Subject: Re: TCP push missing with writev()
In-Reply-To: <Pine.LNX.4.30.0011301710020.8071-100000@artemis.cam.zeus.com> <20001130191414.A13814@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Thu, 30 Nov 2000 19:14:14 +0100
   From: Andi Kleen <ak@suse.de>

   > The problem is that if data happens to be written via method (2),
   > then the PUSH flag is never set on any packets generated. This is
   > a bug, surely?

   I just tried it on 2.2.17 and 2.4.0test11 and it sets PUSH for
   writev() for both cases just fine. Maybe you could supply a test
   program and tcpdump logs for what you think is wrong ?

One thing which could affect the behavior is if the Zeus
folks are futzing around with the TCP_CORK socket option.
Ben, are you guys playing with it?

Finally, are you doing these writes from a userspace program
or directly inside of a kernel module?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
