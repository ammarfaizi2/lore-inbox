Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263757AbTCVRoK>; Sat, 22 Mar 2003 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263762AbTCVRoK>; Sat, 22 Mar 2003 12:44:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12187
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263757AbTCVRoJ>; Sat, 22 Mar 2003 12:44:09 -0500
Subject: Re: IDE todo list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322172453.GB9889@vana.vc.cvut.cz>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
	 <20030322172453.GB9889@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 19:07:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 17:24, Petr Vandrovec wrote:
>   any hope that promise 20265 driver could detect non-udma66 cable
> and run at udma2 only? BIOS properly detect this, but Linux driver
> wants to use udma100, and usually dies hard with CRC errors during
> reading of PTBL extended chain (it also should not lockup when
> CRC error happens 5 times in a row, but ...).

The five CRC in a row is what causes the DMA->PIO changedown. That
implies there is a real bug in the error handling locking, or in
the driver handling of that.

Can you throw some printks into the ide code and see what kind of 
a death you get when it tries to change back to PIO.

As to the cable stuff, I'll take a look at it in time, but both
need fixing

