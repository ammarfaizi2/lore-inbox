Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132231AbRCYWgt>; Sun, 25 Mar 2001 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132237AbRCYWgk>; Sun, 25 Mar 2001 17:36:40 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:6632 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S132231AbRCYWg1>; Sun, 25 Mar 2001 17:36:27 -0500
Message-ID: <3ABE639A.5F45B026@oracle.com>
Date: Sun, 25 Mar 2001 23:31:06 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] Fix for serial.c to work with Xircom Cardbus Ethernet+Modem
In-Reply-To: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com> <3ABBD639.12BE1035@oracle.com> <001e01c0b41d$1665de80$1601a8c0@zeusinc.com> <3ABD2C2A.7333D132@oracle.com> <001701c0b4dc$de099a70$08080808@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
[snip]
> I tested 2.4.3-pre7 and it still fails without my patch.  With my patch I
> get the above message about 'Redundant entry in serial pci_table' but it
> still manages to setup my serial device as /dev/ttyS4 (the same patch
> applied to 2.4.2-ac21 sets the device to /dev/ttyS1).  However it only works
> if I load serial.c as a module AFTER the card is inserted, if serial.c is
> already loaded it doesn't register correctly with a messages similar to
> above.  Perhaps I need to check my hotplug setup.
> 
> Could your try serial.c as a module and see if it works for you like that?
> That way I'd know I'm on the right track and haven't just found some strange
> way to make it work on my system alone.

OK, now I'm in 2.4.3-pre7 plus your patch and serial as a module (it was
 built in kernel previously) and indeed I have my modem detected
 automatically by the PCMCIA startup sequence (I don't need to manually
 do anything).

I lost the IrDA port, though - ttyS2. Now I only see ttyS0 and ttyS4.


Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p18/2.4.3p7 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
