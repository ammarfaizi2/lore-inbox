Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129510AbQKFWG6>; Mon, 6 Nov 2000 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQKFWGi>; Mon, 6 Nov 2000 17:06:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28427 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129510AbQKFWGe>; Mon, 6 Nov 2000 17:06:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: setup.S: A20 enable sequence (once again)
Date: 6 Nov 2000 14:06:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u7a0c$p4u$1@cesium.transmeta.com>
In-Reply-To: <8u6vn8$70i$1@cesium.transmeta.com> <E13stqG-0006eJ-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13stqG-0006eJ-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > This doesn't really work.  Neither the fast A20 gate nor the KBC is
> > guaranteed to have immediate effect (on most systems they won't.)
> 
> Fast A20 gate happens to be immediate on all the embedded kit I know so its
> probably acceptable, and if its too slow it still does the kbc timeout. Since
> its generally on chip they dont muck about talking to keyboard and other junk
> I/O controllers.
> 

I'd rather do it "right", which is to poll for A20 in the same loop as
we wait for the KBC to become available.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
