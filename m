Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbRBLWuj>; Mon, 12 Feb 2001 17:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRBLWu3>; Mon, 12 Feb 2001 17:50:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57605 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129402AbRBLWuK>; Mon, 12 Feb 2001 17:50:10 -0500
Subject: Re: LILO and serial speeds over 9600
To: jas88@cam.ac.uk (James Sutherland)
Date: Mon, 12 Feb 2001 22:50:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.21.0102122211370.22949-100000@yellow.csi.cam.ac.uk> from "James Sutherland" at Feb 12, 2001 10:46:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SRnM-0008Mv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not a huge undertaking, I know, but UDP will probably still be
> a bit simpler. Turn the question around: would using TCP bring any real
> benefits, in a system which will only be used to shift a few kb each boot
> time?

Im not convinced it will be any smaller by the time your UDP code has dealt
with retransmits, out of order acks, and backoff.

> for the kernel-side code: once you have a fully-fledged IP stack, why not
> use it. There's no reason the server couldn't support both, and machines
> would just use whichever was more appropriate at the time.

The IP layer is easy. Thats about 30 lines of code for a minimal IP. You'll
need more code to implement ARP, which you will require

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
