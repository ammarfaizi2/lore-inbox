Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSFLIrL>; Wed, 12 Jun 2002 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSFLIrK>; Wed, 12 Jun 2002 04:47:10 -0400
Received: from naxos.pdb.sbs.de ([192.109.3.5]:11431 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S317419AbSFLIrJ>;
	Wed, 12 Jun 2002 04:47:09 -0400
Subject: Re: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: osb4-bug@ide.cabal.tm,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E17I3xY-0007Hu-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 10:47:28 +0200
Message-Id: <1023871648.23733.465.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2002-06-12 um 10.58 schrieb Alan Cox:
> Triggering the check on csb5/csb6 would be a bug - maybe an extra 
> test is needed there as CSB5/6 are fine

Currently the stall is triggered if the DMA engine active bit is set, no
further conditions.

Would you concur that it would be reasonable to trigger only if

- the chipset version is < CSB5,
- the drive is a hard disk,
- and the drive did not report an error?

(I am not certain about the last condition, but from the descriptions 
of the 4-byte-shift problem I have seen I infer that there was no drive
error condition involved).

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





