Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbQLGRRF>; Thu, 7 Dec 2000 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLGRQz>; Thu, 7 Dec 2000 12:16:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56587 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129257AbQLGRQu>; Thu, 7 Dec 2000 12:16:50 -0500
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
To: proski@gnu.org (Pavel Roskin)
Date: Thu, 7 Dec 2000 16:48:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        zaitcev@metabyte.com (Pete Zaitcev)
In-Reply-To: <Pine.LNX.4.30.0012071108220.23591-100000@fonzie.nine.com> from "Pavel Roskin" at Dec 07, 2000 11:44:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1444E0-0002fW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, it's not just a matter of changing the constants under "case
> SNDCTL_DSP_SPEED" in ymf_ioctl()? Actually, I hacked them to be
> 4000<rate<50000 and it worked fine, but I'll drop this part of my patch if
> you believe it's unsafe.

I'd keep it in the absence of other evidence. 8KHz is normally the low limit
for AC97 codec based systems, but if the rate adaption is done in front of
the codec then it may well be fine

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
