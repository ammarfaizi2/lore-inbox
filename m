Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290643AbSBLAdb>; Mon, 11 Feb 2002 19:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290644AbSBLAdV>; Mon, 11 Feb 2002 19:33:21 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.36.1]:16915 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S290643AbSBLAdK>; Mon, 11 Feb 2002 19:33:10 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200202120033.g1C0X2b10435@wave.physics.adelaide.edu.au>
Subject: Tulip oddity under 2.2.19 - possible bug?
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Feb 2002 11:03:01 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

[ Please CC me any replies since I read the list through a web archive which
  sometimes misses messages ]

In recent times I have encounted an oddity while using a tulip-based NIC
under 2.2.19.  I am wondering whether it's associated with a known issue or
whether it's indicating a hardware fault of some description.

The kernel is the stock Linus 2.2.19 (as supplied in Slackware 8.0).

The arrangement: there are two machines conected with a crossed UTP cable. 
One is the Linux box and the other is an NT4 box.  Both have identical NICs
based on the Tulip chip (DEC 21041).

The symptoms: if both PCs are powered up simultaneously everything comes up
fine - communication on the network proceeds normally.  If the NT box is for
some reason reset (without the Linux box going down), the network connection
is not re-established successfully once NT comes back up again.  Trying to
ping the NT box causes the "tx/rx" led on the back of the linux NIC to
blink, but nothing is sent back from the NT box.  Interestingly enough,
ifconfig reports some carrier errors in the fault condition.  Rebooting the
NT4 box doesn't fix the problem; however, doing
  ifconfig eth0 down
  ifconfig eth0 up
on the Linux box does fix the problem.

If the network isn't connected when the Linux box is booted, a similar
problem occurs - once the network cable is connected the linux box needs the
above ifconfig cycle to be run before the network connection is
successfully established.

In addition to the above situation, I have also experienced similar hangups
in another box.  In this case the linux box has a Lite-On card (LNE100TX)
connected to a 100Mbps repeater; it is running 2.2.19 as per the other box
I've mentioned.  On boot everything is fine, but if the link goes down (the
repeater is reset for example), the Linux box looses network connectivity
until the ifconfig cycle is carried out.

During or after the fault condition nothing is written to any log files to
indicate a problem.

Is this a known issue with a workaround available, or is it indicative of a
hardware error?

If any further info is required please drop me an email and I'll try to
obtain the requested details.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
