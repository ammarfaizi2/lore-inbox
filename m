Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRDXDjW>; Mon, 23 Apr 2001 23:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132737AbRDXDjM>; Mon, 23 Apr 2001 23:39:12 -0400
Received: from ohiper1-166.apex.net ([209.250.47.181]:34309 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132733AbRDXDjE>; Mon, 23 Apr 2001 23:39:04 -0400
Date: Mon, 23 Apr 2001 22:38:48 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: serial driver not properly detecting modem
Message-ID: <20010423223847.A3945@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 10:30pm  up  2:10,  1 user,  load average: 1.45, 1.38, 1.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem that I have a modem (hardware based, not winmodem) of
PCI_CLASS_COMMUNICATION_OTHER.  This, unfortunately, prevents it from
being automagically detected by the serial driver, which only looks for
devices of PCI_CLASS_COMMUNICATION_SERIAL.

I've fixed this here merely by adding an entry to the PCI table of
serial.c for PCI_CLASS_COMMUNICATION_OTHER.  Is this the best way to fix
this?  Is there some reason that this shouldn't be done in general?  If
not, I'd like to see it fix in the kernel proper.

It should be noted that the modem is listed in serial.c's pci_boards,
perhaps it would be best for the serial driver to list PCI_ID_ANY for a
class, and only use pci_boards to further identify serial ports?  Or
would this be too inefficient to correct for a few misguided hardware
makers?

Thanks
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
