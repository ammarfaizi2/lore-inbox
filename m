Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBKRtL>; Sun, 11 Feb 2001 12:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbRBKRsw>; Sun, 11 Feb 2001 12:48:52 -0500
Received: from 13dyn164.delft.casema.net ([212.64.76.164]:39686 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129055AbRBKRsr>; Sun, 11 Feb 2001 12:48:47 -0500
Message-Id: <200102111748.SAA10087@cave.bitwizard.nl>
Subject: Re: [QUESTION]: IDE Driver support for S.M.A.R.T?
In-Reply-To: <E14RuJY-0003ru-00@the-village.bc.nu> from Alan Cox at "Feb 11,
 2001 11:05:05 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 11 Feb 2001 18:48:42 +0100 (MET)
CC: Shawn Starr <Shawn.Starr@Home.net>, lkm <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Does the current (E)IDE driver support SMART?

> Yes

My server disk reports:

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 9
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x0029   100   253   020       000000000000
(  3)Spin Up Time            0x0027   078   078   020       000000000aff
(  4)Start Stop Count        0x0032   100   100   008       000000000014
(  5)Reallocated Sector Ct   0x0033   100   100   020       000000000000
(  7)Seek Error Rate         0x000b   100   100   023       000000000000
(  9)Power On Hours          0x0012   084   084   001       000000002ae7
( 11)Unknown Attribute       0x0013   100   100   020       000000000000
( 12)Power Cycle Count       0x0032   100   100   008       000000000014
( 13)Unknown Attribute       0x000b   100   100   023       000000000000
(199)UDMA CRC Error Count    0x001a   200   200   000       000000000000
(198)Offline Uncorrectable   0x0010   100   253   000       000000000000

(uptime of the machine is 81 hours longer than power on hours of the
disk. Seems that there is a small discrepancy... Hmm. Just checked:
The disk looses one hour every week)

I think that "Power on hours value = 084" means that the disk thinks
that it's seen about 1/6th of it's lifetime. The number seems to drop
by one about once every month.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
