Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264271AbRFGBHs>; Wed, 6 Jun 2001 21:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264273AbRFGBHi>; Wed, 6 Jun 2001 21:07:38 -0400
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:51777 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S264271AbRFGBHb>; Wed, 6 Jun 2001 21:07:31 -0400
Date: Thu, 7 Jun 2001 03:07:18 +0200 (CEST)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, cr@sap.com
cc: Linux on 390 Port <LINUX-390@VM.MARIST.EDU>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: SHM/TMPFS broken on s390x in 2.4.5
Message-ID: <Pine.LNX.4.05.10106070249130.25664-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

I tried 2.4.5-ac8 which includes the newest s390-Patches from IBM and I
found out, that it is possible to access shared memory but when you
free it, the machine crashs.
The output on console seems to come from __swap_free in swapfile.c:
It was a mixture of
  swap_free: Trying to free nonexistent swap-page
  swap_free: offset exceeds max
If you need detailed order of those messages I could reproduce a crash for
you. ;-)

I reproduced it with 2.4.5 and 2.4.5-ac8 but I never tested  2.4.4,
but having a quick look at the code it saw that shm changed from 2.4.3 to 
2.4.4.

2.4.3 runs very stable on my architecture.
For everything else 2.4.5-ac8 seems to run quite fine on zSerie.

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 


