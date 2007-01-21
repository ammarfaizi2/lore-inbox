Return-Path: <linux-kernel-owner+w=401wt.eu-S1751195AbXAUFbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbXAUFbi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 00:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXAUFbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 00:31:38 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:3866 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXAUFbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 00:31:37 -0500
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 00:31:37 EST
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Joe Barr'" <joe@pjprimer.com>,
       "'Linux Kernel mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial port blues
Date: Sun, 21 Jan 2007 00:09:39 -0500
Organization: Connect Tech Inc.
Message-ID: <09dd01c73d1a$5a71a5f0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <1169242654.20402.154.camel@warthawg-desktop>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Joe Barr
> I'm forwarding this post by the author of a great little program for
> digital amateur radio on Linux, because I'm curious whether or not the
> problem he is seeing can be resolved outside the kernel.

From: w1hkj [mailto:w1hkj@w1hkj.com] 
> I am now convinced that the current serial port drivers 
> available to us 
> on the Linux platform WILL NOT support CW and/or RTTY that is 
> software 
> generated in a satisfactory manner.

I don't know what FSK/CW/RTTY/BAUDOT is.

> Direct access to the serial port(s) is a kernel perogative in Linux.  
> Only kernel level drivers are allowed such port access.

Not true.

> Until such time as new information becomes available I am going to 
> comment out all references to CW and / or FSK via RTS/DTR.  I also 
> question how useful the FSK on TxD (UART derived) might be to 
> most users 
> since the 45.45 baudrate is not available in the serial port driver.  
> That function will also be commented out.

You may be confusing the old-style baud rate lookup table (B9600 et
al) with the actual capabilities of the serial port. The lookup table
has a limited number of baud rates. You can get more rates than that
using a custom divisor. Most motherboard-based serial ports are
clocked at 1.8432 Mhz. The UART does 16 samples per bit time, yielding
a max baud rate of 115200.

115200 / 25 yields 4608, which is a 1.4% error rate from 4545. This
may or may not be acceptable. 115200 / 2535 yields 45.44, which is a
0.01% error rate, which is likely acceptable.

> Sorry folks, but we win some and lose some.

We make serial port boards with very flexible UARTS. 4545 exactly is
achievable. 45.45 too. Linux supported.

..Stu

-- 
We make multiport serial products.
http://www.connecttech.com/
(800) 426-8979

