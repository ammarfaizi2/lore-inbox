Return-Path: <linux-kernel-owner+w=401wt.eu-S965296AbXATPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbXATPl4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbXATPl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:41:56 -0500
Received: from miggins.aqhostdns.com ([216.93.243.2]:44282 "EHLO
	miggins.aqhostdns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965296AbXATPlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:41:55 -0500
X-Greylist: delayed 65064 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 10:41:55 EST
Subject: Serial port blues
From: Joe Barr <joe@pjprimer.com>
To: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-yyTwYkKzxGpZ8FEa4rxS"
Date: Fri, 19 Jan 2007 15:37:34 -0600
Message-Id: <1169242654.20402.154.camel@warthawg-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-Antivirus-Scanner: Scanned and found to be clean by AQHost - http://www.AQHost.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - miggins.aqhostdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pjprimer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yyTwYkKzxGpZ8FEa4rxS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I'm forwarding this post by the author of a great little program for
digital amateur radio on Linux, because I'm curious whether or not the
problem he is seeing can be resolved outside the kernel.

All comments welcome on/off list.

Thanks,
Joe Barr
K1GPL



-- 
It's a strange world when proprietary software is not worth stealing,
but free software is.


--=-yyTwYkKzxGpZ8FEa4rxS
Content-Disposition: inline
Content-Description: Forwarded message - FSK/CW and ioctl jitter / latency
Content-Type: message/rfc822

Return-path: <w1hkj@w1hkj.com>
Envelope-to: k1gpl@linuxhamshack.org
Delivery-date: Fri, 19 Jan 2007 14:33:39 -0500
Received: from warthawg by miggins.aqhostdns.com with local-bsmtp (Exim
	4.63) (envelope-from <w1hkj@w1hkj.com>) id 1H7zUV-00036d-UI for
	k1gpl@linuxhamshack.org; Fri, 19 Jan 2007 14:33:38 -0500
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on 
	miggins.aqhostdns.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.1.7
Received: from [68.168.78.211] (port=47980 helo=mta16.adelphia.net) by
	miggins.aqhostdns.com with esmtp (Exim 4.63) (envelope-from
	<w1hkj@w1hkj.com>) id 1H7zUV-000359-Nm for k1gpl@linuxhamshack.org; Fri, 19
	Jan 2007 14:33:35 -0500
Received: from [192.168.2.51] (really [24.126.19.211]) by
	mta16.adelphia.net (InterMail vM.6.01.05.04 201-2131-123-105-20051025) with
	ESMTP id <20070119191640.SDAU2311.mta16.adelphia.net@[192.168.2.51]>; Fri,
	19 Jan 2007 14:16:40 -0500
Message-ID: <45B11CEC.4080806@w1hkj.com>
Date: Fri, 19 Jan 2007 14:33:00 -0500
From: w1hkj <w1hkj@w1hkj.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David <djmunn@bigpond.com>, Dave Cooper <ve3ixi@cabletv.on.ca>,  Phil Moore <pm88re@gmail.com>, jhaynesatalumni <jhhaynes@earthlink.net>,  David Karipides <dkaripides@woh.rr.com>, Walter Fey <walter.fey@web.de>, edw3nr <autek@comcast.net>,  Mike Phipps <kd8dkt@gmail.com>, Rick Kunath <k9ao@charter.net>,  Brett Owen Rees VK2TMG <breree@gmail.com>, David Quental <ct1drb@iol.pt>, =?ISO-8859-1?Q?P=E4r_Crusefalk?= <per@crusefalk.se>, PA0R <rein@couperus.com>,  Bob Christenson <bchristenson@mchsi.com>, Joe Barr <k1gpl@linuxhamshack.org>, Joe Veldhuis <jvn8fq@gmail.com>,  Diane Bruce <db@db.net>, Walter Giovanni <wgiovan@chasque.net>
Subject: FSK/CW and ioctl jitter / latency
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-Antivirus-Scanner: Scanned and found to be clean by AQHost -
	http://www.AQHost.com
Content-Transfer-Encoding: 7bit

I've spent the last day staring at the oscilloscope and pins RTS and DTR 
on the serial output for 4 different computers running 4 different 
versions of Linux.  Also have exhausted the search on the internet for 
information regarding both the latency and jitter associated with ioctl 
calls to the serial driver (both ttyS and ttyUSB).  I'm sure it is out 
there somewhere, I just cannot find it.

I am now convinced that the current serial port drivers available to us 
on the Linux platform WILL NOT support CW and/or RTTY that is software 
generated in a satisfactory manner.

To test the latency and jitter of the ioctl calls to set or clear RTS 
and / or DTR I built a basic square wave generator with microsecond 
timing precision.  The timing could be derived either from the select 
system call or by controlled i/o to the sound card.  Both provide very 
precise timing of the program loop.  Each time through the loop either 
the RTS/DTR was set or cleared.  The timing jitter for each 1/2 cycle 
was from 0 to +4 msec.  This varied between systems as each had 
different cpu clock rates.  The jitter is caused by the asynchronous 
response of the kernel to the request to control the port.  ioctl 
requests apparantly do not have a very high priority for the kernel.  
They are probably just serviced by a first-in first-out interrupt 
service request loop.  That type of jitter is tolerable up to about 20 
wpm CW.  It totally wipes out the ability to generate an FSK signal on 
the DTR or RTS pin.

Direct access to the serial port(s) is a kernel perogative in Linux.  
Only kernel level drivers are allowed such port access.

So ... bottom line is that all of my attempts over the past couple of 
months to provide CW and / or FSK output signal have been to fraught 
with pitfalls.  The CW seems OK for slow speed keying, but the FSK seems 
impossible to achieve.

The FSK using the UART is also limited by the Linux operating system and 
the current drivers.  That limitation excludes the use of 45 or 56 baud 
BAUDOT.

Until such time as new information becomes available I am going to 
comment out all references to CW and / or FSK via RTS/DTR.  I also 
question how useful the FSK on TxD (UART derived) might be to most users 
since the 45.45 baudrate is not available in the serial port driver.  
That function will also be commented out.

All this should not really come as a surprise since Linux is not a 
real-time operating system. By the way, I did try the tests with the 
test program running with nice -20.  Not much difference.

Sorry folks, but we win some and lose some.

73, Dave, W1HKJ


--=-yyTwYkKzxGpZ8FEa4rxS--

