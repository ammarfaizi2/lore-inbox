Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130050AbRB1CqG>; Tue, 27 Feb 2001 21:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130051AbRB1Cpr>; Tue, 27 Feb 2001 21:45:47 -0500
Received: from ns1.dohring.com ([64.210.3.222]:44539 "EHLO
	mailserver.dohring.com") by vger.kernel.org with ESMTP
	id <S130050AbRB1Cpn>; Tue, 27 Feb 2001 21:45:43 -0500
Message-ID: <3A9C6620.F380491@neopets.com>
Date: Tue, 27 Feb 2001 18:44:48 -0800
From: Gashaw Teshome <gasht@neopets.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2 & eepro100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently compiled a fresh download of a 2.4.2 kernel to test a server
at work.  The machine is a dual P-III, 512 MB RAM on an Intel L440GX+
motherboard with a built in eepro100 network interface.  Almost
immediately after boot up, the kernel started reporting:

Feb 23 19:40:23 www136 kernel: NET: 486 messages suppressed.
Feb 23 19:40:29 www136 kernel: NET: 858 messages suppressed.
Feb 23 19:40:33 www136 kernel: NET: 879 messages suppressed.
Feb 23 19:40:38 www136 kernel: NET: 983 messages suppressed.
Feb 23 19:40:43 www136 kernel: NET: 1296 messages suppressed.
Feb 23 19:40:49 www136 kernel: NET: 1780 messages suppressed.
Feb 23 19:40:53 www136 kernel: NET: 1378 messages suppressed.
Feb 23 19:40:58 www136 kernel: NET: 246 messages suppressed.
Feb 23 19:41:04 www136 kernel: NET: 173 messages suppressed.
Feb 23 19:41:09 www136 kernel: NET: 32 messages suppressed.
Feb 23 19:42:32 www136 kernel: NET: 37 messages suppressed.

At the same time, our bandwidth graph (rrdtool) showed almost zero
network traffic.  Also, load on the test machine went to 30!  After the
errors went away, bandwidth returned to normal and load went down
considerably.

This cycle (error message, extremely high load, zero bandwidth) repeated
about every half hour and lasted for about 1 1/2 minutes.  I eventually
took the machine down and rebooted it with its original 2.2 kernel. 
There were no more error messages or bandwidth drops after that.

I have heard mentioned that there are some issues with the eepro100
driver in 2.4.x.  Could that be the cause of this strange behaviour? 
Any help would be appreciated.


Gash Teshome
