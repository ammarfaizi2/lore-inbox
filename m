Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132745AbRDQQQC>; Tue, 17 Apr 2001 12:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132744AbRDQQPn>; Tue, 17 Apr 2001 12:15:43 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:41180 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132743AbRDQQPh>; Tue, 17 Apr 2001 12:15:37 -0400
Date: Tue, 17 Apr 2001 18:15:24 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417181524.E2589096@informatics.muni.cz>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <E14pXxg-0002cI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14pXxg-0002cI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 17, 2001 at 05:04:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
: > : but once a fixed BIOS is out for your board that would be a good first step.
: > : If it still does it then, its worth digging for kernel naughties
: > : 
: > 	I don't think I have 686b southbridge. I have 686 (without "b"):
: 
: Ok. What revision of 3c90x card do you have ?
: 
PCI: Found IRQ 11 for device 00:0c.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0xa000,  00:50:da:06:95:21, IRQ 11
  product code 5957 rev 00.13 date 07-17-99
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled

	Some more progress: I now downgraded to proftpd without sendfile().
The CPU usage is now nearly 100% (with ~170 FTP users; with sendfile()
it was under 50% with >320 FTP users). But nevertheless, the downloaded
images now seem to be OK.

	Should I try the stock 2.4.3 without zero-copy patches?

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
///... in B its 'extrn' not 'extern'.        Alan (yes I programmed in B)\\\

