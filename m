Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263072AbREaLdc>; Thu, 31 May 2001 07:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbREaLdW>; Thu, 31 May 2001 07:33:22 -0400
Received: from goliath.siemens.de ([194.138.37.131]:8687 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S263072AbREaLdS>; Thu, 31 May 2001 07:33:18 -0400
X-Envelope-Sender-Is: Andrej.Borsenkow@mow.siemens.ru (at relayer goliath.siemens.de)
From: "Andrej Borsenkow" <Andrej.Borsenkow@mow.siemens.ru>
To: <linux-kernel@vger.kernel.org>
Subject: NULL characters in file on ReiserFS again.
Date: Thu, 31 May 2001 15:33:06 +0400
Message-ID: <000201c0e9c5$7643d540$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened to me yesterday on kernel-2.4.4-6mdk (Mandrake cooker, based
on 2.4.4-ac14), single reiser root filesystem, mounted with default options.
Hardware - ASUS CUSL2 (i815e chipset), Fujitsu UDMA-4 drive.

I tried to change hostname and did not have the corresponding entry in
/etc/hosts (or anywhere). As a tesult, startx hung starting X server; it was
not possible to switch to alpha console or kill X server. I pressed reset
and after reboot looked into /var/log/XFree86*log - and there were a bunch
of ^@ there.

I then run fsck from another system (installed on another partition) but
there was no errors (well, new errors - there was off-by-one free blocks
bitmap mismatch but it was always there, I do not know how to correct it). I
tried the above once more but this time XFree log was O.K.

So, I really do not know how to reproduce it, but I wanted to give a warning
that a problem still exists (albeit in emergency situation). As Reiser does
not do any fsck after crash, the problem is serious enough IMHO.

-andrej

