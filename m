Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135510AbRAGRcm>; Sun, 7 Jan 2001 12:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136144AbRAGRcc>; Sun, 7 Jan 2001 12:32:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135371AbRAGRcW>; Sun, 7 Jan 2001 12:32:22 -0500
Subject: Re: Even slower NFS mounting with 2.4.0
To: trond.myklebust@fys.uio.no
Date: Sun, 7 Jan 2001 17:33:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <14936.42515.988953.602296@charged.uio.no> from "Trond Myklebust" at Jan 07, 2001 06:23:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FJgu-00030E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm... How should we respond to that sort of thing? In principle the
> NFS layer supposes that if we have a hard mount, then unreachable
> ports etc are a temporary problem, and we should wait them out.  (In
> fact, I've made an RPC 'ping' routine that improves on that behaviour
> but which unfortunately didn't make it into 2.4.0.)

That makes reasonable sense once mounted. I think mount needs to be polite
until it decides the mount is made


> If we want to check that the port is reachable at the moment when we
> mount, I think we should concentrate on making 'mount' more
> intelligent. Perhaps have it RPC-ping the various ports (including the
> local portmapper when we specify locking)?

That would work.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
