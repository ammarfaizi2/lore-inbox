Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265254AbSKAQxg>; Fri, 1 Nov 2002 11:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSKAQxg>; Fri, 1 Nov 2002 11:53:36 -0500
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:30983 "EHLO
	skarpsey.dyndns.org") by vger.kernel.org with ESMTP
	id <S265254AbSKAQxe> convert rfc822-to-8bit; Fri, 1 Nov 2002 11:53:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: AlphaPC+Sym53c8xx driver failure
Date: Fri, 1 Nov 2002 11:55:42 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211011055.42642.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I got my hands on a PC164LX system with a Symbios 53c810 
controller.  One of the first things I did was install Debian 
Woody on it, and it went on without too much fuss using kernel 
2.2.20.

Next thing I tried was upgrading to a 2.4 kernel.  Currently I'm 
trying 2.4.16; it boots to the point of scanning the Symbios 
controller, then doesn't get any further (and no terribly 
obvious error message either).  After booting with 
"sym53c8xxx=safe:y,verb:2,debug:0x1fff,wide:0", I got something 
a little more informative...the controller gets to "command 
processing suspended for 10 seconds" to "command processing 
resumed" and finally to "queuepos=2"--and that's all she wrote.

I've dug up two separate options for supporting this controller 
(sym53c8xx_2 and ncr53c8xx); both have about the same results.  
I would think it's a hardware fault, but it works in 2.2.20?

2.4.18 and 2.4.19 did much the same thing when I tried them (they 
failed in many other ways as well, but 2.4.16 doesn't seem to 
hork on itself quite so much, just the sym53c8xxx driver).

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

