Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGIKwM>; Tue, 9 Jul 2002 06:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGIKwL>; Tue, 9 Jul 2002 06:52:11 -0400
Received: from gsd.di.uminho.pt ([193.136.20.132]:942 "HELO
	homer.lsd.di.uminho.pt") by vger.kernel.org with SMTP
	id <S313558AbSGIKwI> convert rfc822-to-8bit; Tue, 9 Jul 2002 06:52:08 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jose Orlando Pereira <jop@lsd.di.uminho.pt>
Organization: Universidade do Minho
To: linux-kernel@vger.kernel.org
Subject: IDE corruption with ServerWorks OSB4 and 2.4.18 + Fix
Date: Tue, 9 Jul 2002 11:54:39 +0100
X-Mailer: KMail [version 1.4]
Cc: Andre Hedrick <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207091154.39789.jop@lsd.di.uminho.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an experience report. I hope it is useful. I don't know if this is 
known fact, but I've not been able to find it by searching the archives.
I've found only a reference to using MWDMA2 and loosing some
performance.

I've been using 2.4.6 (plain) on a couple of OSB4-based machines which boot 
with UDMA2 enabled with no problem whatsoever. Recently, I've upgraded one of 
them to 2.4.18-3smp (RedHat), which doesn't use DMA by default. Using hdparm 
-d1 to activate DMA results either in an error message about OSB4 and freeze 
or in a very severe corruption of the root partition (reinstallation 
required).

After some experimentation, and by comparing /proc/ide/hda/settings with the 
machine still running 2.4.6, I've tryied setting hdparm -X66 before using -d1 
and it now works *reliably* and fast (21Mb/s).

If anybody wants further information about the hardware or wants to
experiment better fixes, please ask. I don't mind reinstalling the thing a few 
more times. :-)

-- 
Jose Orlando Pereira
* mailto:jop@di.uminho.pt * http://gsd.di.uminho.pt/~jop *
