Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131422AbRBLVwo>; Mon, 12 Feb 2001 16:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbRBLVwe>; Mon, 12 Feb 2001 16:52:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27397 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130534AbRBLVwY>; Mon, 12 Feb 2001 16:52:24 -0500
Subject: Re: LILO and serial speeds over 9600
To: jas88@cam.ac.uk (James Sutherland)
Date: Mon, 12 Feb 2001 21:52:20 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.21.0102122025320.22949-100000@yellow.csi.cam.ac.uk> from "James Sutherland" at Feb 12, 2001 08:39:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SQtT-0008C5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have toyed a few times about having a simple Ethernet- or UDP-based
> > console protocol (TCP is too heavyweight, sorry) where a machine would
> > seek out a console server on the network.  Anyone has any ideas about
> > it?
> 
> Excellent plan: data centre sysadmins the world over will worship your
> name if it works...

Sounds like MOP on the old Vaxen. TCP btw isnt as heavyweight as people 
sometimes think. You can (and people have) implemented a simple TCP client
and IP and SLIP in 8K of EPROM on a 6502. There is a common misconception
that a TCP must be complex.

All you actually _have_ to support is receiving frames in order, sending one
frame at a time when the last data is acked and basic backoff. You dont have
to parse tcp options, you dont have to support out of order reassembly.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
