Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbREUNMx>; Mon, 21 May 2001 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbREUNMo>; Mon, 21 May 2001 09:12:44 -0400
Received: from venus.postmark.net ([207.244.122.71]:62477 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S261345AbREUNMa>; Mon, 21 May 2001 09:12:30 -0400
Message-ID: <20010521115016.5262.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com
Subject: Re: tulip driver BROKEN in 2.4.5-pre4
Date: Mon, 21 May 2001 11:50:16 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you post the output of
> 
> #tulip-diag -mm -aa -f
> 
> with the broken driver?
> Some code that's required for Linksys Tulip clones was moved
> from pnic specific part into the generic part, perhaps that
> causes problems.

Here is the output from the kernels I've tested to try to get the
driver working:

2.4.4-ac6, this kernel works!

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0xd800.
Digital DC21041 Tulip chip registers at 0xd800:
 0x00: ffe08000 ffffffff ffffffff 0129f000 0129f200 fc660000 fffe2002
ffffebef
 0x40: fffe0000 ffff03ff ffffffff fffe0000 000001c8 ffffef05 ffffff3f
ffff0008
 Port selection is half-duplex.
 Transmit started, Receive started, half-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000001c8.
   No MII transceivers found!
  Internal autonegotiation state is 'Autonegotiation disabled'.

--------------------------------------------------------------

2.4.5-pre4 this kernel doesn't work

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0xd800.
Digital DC21041 Tulip chip registers at 0xd800:
 0x00: ffe08000 ffffffff ffffffff 0129e000 0129e200 fc660000 fffe2202
ffffebef
 0x40: fffe0000 ffff03ff ffffffff fffe0000 000050c8 ffffef01 ffffffff
ffff0008
 Port selection is full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000050c8.
   No MII transceivers found!
  Internal autonegotiation state is 'Negotiation complete'.

--------------------------------------------------------------

2.4.4-ac9 with tulip 1.1.7 driver (from sf.net/projects/tulip)

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0xd800.
Digital DC21041 Tulip chip registers at 0xd800:
 0x00: ffe08000 ffffffff ffffffff 0129f000 0129f200 fc660000 fffe2202
ffffebef
 0x40: fffe0000 ffff03ff ffffffff fffe0000 000050c8 ffffef01 ffffffff
ffff0008
 Port selection is full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000050c8.
   No MII transceivers found!
  Internal autonegotiation state is 'Negotiation complete'.


 Let me know if I can provide any more useful information about the
driver problem.

    John
----------------
jbk@postmark.net

