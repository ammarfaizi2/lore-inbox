Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131641AbQLJSwj>; Sun, 10 Dec 2000 13:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131961AbQLJSwT>; Sun, 10 Dec 2000 13:52:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131940AbQLJSvr>; Sun, 10 Dec 2000 13:51:47 -0500
Subject: Re: Traffic storm interaction with MacOS 8.6
To: j.d.morton@lancaster.ac.uk (Jonathan Morton)
Date: Sun, 10 Dec 2000 18:23:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <l0313030bb658f80c3180@[192.168.239.101]> from "Jonathan Morton" at Dec 10, 2000 10:07:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145B8R-0006ox-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Analysis:
> 	This is probably a bug in the MacOS, as well as in Linux, and the
> presence of both is necessary to cause the effect.  I believe it can be

I would imagine its a bug in some mangling proxy in the middle. MacOS is
mentat streams which while not reknowned for its behaviour certainly isnt
normally in the complete idiot category

> systems, in the following manner.  The workaround involves NOT sending more
> than one TCP responses in a row which advertise a zero receive window,

Thats not legal. RFC's are explicit about when you send acks

> eliminating the storm.  When the receive window becomes available again, a
> single, empty TCP packet would be generated advertising the new window
> size; this I believe is already present.

This packet is unreliable so the acks must happen.

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
