Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRJWIzp>; Tue, 23 Oct 2001 04:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279324AbRJWIzg>; Tue, 23 Oct 2001 04:55:36 -0400
Received: from [62.116.8.197] ([62.116.8.197]:32386 "HELO
	ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S279323AbRJWIz0>; Tue, 23 Oct 2001 04:55:26 -0400
From: "clemens" <therapy@endorphin.org>
Date: Tue, 23 Oct 2001 10:55:53 +0200
To: Volker Dierks <vd@mwi-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA 686b Bug - once again :(
Message-ID: <20011023105553.A1891@ghanima.endorphin.org>
In-Reply-To: <200110211326.PAA01192@mail.mwi-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110211326.PAA01192@mail.mwi-online.de>
User-Agent: Mutt/1.3.23i
X-Delivery-Agent: TMDA v0.37/Python 2.0.1 (linux2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 01:26:11PM -0000, Volker Dierks wrote:

> I searched 1 hour on google but
> the only solution seems to be a
> fix with loadlin and pciset from
> Thilo <Free.Spirit@gmx.net>

have a look at:

http://www.viahardware.com/686bfaq.shtm
http://www.au-ja.org/review-kt133a-1.phtml (german)

basically you have to find a way to set some specific PCI registers of the
northbridge. 
check out the write handler of this is /proc/bus/pci/00/00.0
it's at linux/drivers/pci/proc.c:proc_bus_pci_write

basically it looks like you have to seek to the "register" via lseek and
then write the control value.
shouldn't be that hard.

in worst case you could write a 20-line linux kernel module to set the
few required pci registers.

clemens
