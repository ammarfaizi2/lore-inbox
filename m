Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285056AbRLFIpg>; Thu, 6 Dec 2001 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285055AbRLFIp1>; Thu, 6 Dec 2001 03:45:27 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:4878 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S285050AbRLFIpL>; Thu, 6 Dec 2001 03:45:11 -0500
Date: Thu, 6 Dec 2001 10:45:10 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
Message-ID: <20011206104510.A32451@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112051609200.21129-100000@rtlab.med.cornell.edu> <E16BmbY-0008DS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BmbY-0008DS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 12:41:36AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 12:41:36AM +0000, Alan Cox wrote:
> We already have one. The Linux folks saw the problem much earlier than
> windows people because our athlon optimised memory copies triggered it
> reliably on many boards.

The details were a bit different in that web page:

Linux looks for chip with id 1106:0305 (KT133) and clears only bit 7 of
register 55. The Windows driver checks for chips 1106:0305, 1106:3099,
1106:3102, 1106:3112, and clears three bits: bits 5-7 of that register. In
addition, the web page tells that it's probably not right for 1106:3099
(KT266) because there it should be register 95.

Maybe this is not relevant: maybe all BIOSes for KT266 chipsets already set
the right values and maybe KT133 boards with problems only have bit 7 set,
not bits 5 and 6. (PCs here with KT133 already have all bits 5-7 zero in
reg. 55 and PCs with KT266 have bits 5-7 both in reg. 55 and 95 zero.)
