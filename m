Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLOTqZ>; Fri, 15 Dec 2000 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQLOTqQ>; Fri, 15 Dec 2000 14:46:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129413AbQLOTqD>; Fri, 15 Dec 2000 14:46:03 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 15 Dec 2000 19:17:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jjs@toyota.com (J Sloan),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <20001215200906.H17781@inspiron.random> from "Andrea Arcangeli" at Dec 15, 2000 08:09:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1470MY-0001ib-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now we know when we can block so we can run f_ops->write ourselfs that's also
> more efficient in terms of both performance and also memory pressure during
> swap of course.

Yep

> As said reiserfs AFIK didn't need any change, so only VFS is using
> fs_down/fs_up from the point of view of reiserfs.

Ok. Im not keen on adding fs_down but it does look like the right bandage
(and a nice speed up) for 2.2. 

I hate that kind of bug

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
