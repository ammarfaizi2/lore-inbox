Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbRE1XRJ>; Mon, 28 May 2001 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbRE1XQ7>; Mon, 28 May 2001 19:16:59 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:51204 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S261696AbRE1XQv>; Mon, 28 May 2001 19:16:51 -0400
Date: Mon, 28 May 2001 17:16:47 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Current tulip driver from 2.4.5 is plain broken
Message-ID: <20010528171647.D12494@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mentioned that before but this should be stated clearly.  As far as I
am concerned "Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)",
as used in 2.4.5 - and other kernels - is totally buggered.  It comes up,
and ethernet interfaces can be configured, but does not matter how I am
playing with options I cannot get a single packet through.

Replacing it in 2.4.5 with "Linux Tulip driver version 0.9.14d (April 3,
2001)", which I have handy, restores sanity immediately and a network
simply works without any heroic efforts.

My NIC is "Digital DS21143 Tulip rev 65 at 0x8800".  BTW - a version
"tulip-1.1.7" from sourceforge behaves exactly like 0.9.15-pre2.

This is an output of 'tulip-diag -af' from a working setup:

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0x8800.
Digital DS21143 Tulip chip registers at 0x8800:
 0x00: f8a0e000 ffffffff ffffffff 0d572000 0d572200 f0660000 b2422002 fbfffbff
 0x40: e0000000 fff583ff ffffffff 00000000 000052ca ffff0001 fffbffff 8ffd0008
 Port selection is 10mpbs-serial, half-duplex.
 Transmit started, Receive started, half-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 72.
  The NWay status register is 000052ca.
  Internal autonegotiation state is 'Negotiation complete'.

And this what shows up when I am trying to use "the-new-and-improved":

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0x8800.
Digital DS21143 Tulip chip registers at 0x8800:
 0x00: f8a0d000 ffffffff ffffffff 0b9f4000 0b9f4200 f0000000 b2420200 fbfffbff
 0x40: e0000000 fff483ff ffffffff 00000000 000060ca ffff0001 fffbffff 8ffd0000
 Port selection is 10mpbs-serial, full-duplex.
 Transmit stopped, Receive stopped, full-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 72.
  The NWay status register is 000060ca.
  Internal autonegotiation state is 'Link check'.

Comments?

    Michal
    michal@harddata.com

