Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSGDREK>; Thu, 4 Jul 2002 13:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSGDREJ>; Thu, 4 Jul 2002 13:04:09 -0400
Received: from vvv.conterra.de ([212.124.44.162]:12562 "EHLO vvv.conterra.de")
	by vger.kernel.org with ESMTP id <S313898AbSGDREJ>;
	Thu, 4 Jul 2002 13:04:09 -0400
Message-ID: <3D24809B.2A2B51B2@conterra.de>
Date: Thu, 04 Jul 2002 19:06:35 +0200
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: still pdc202x problems with 2.4.19-rc1
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to run a MAXTOR 120G on a PDC (promise) controller.
Using 2.5.19-pre10-ac2 or 2.4.19-rc1 the system does not
hang any more during partition check, but I still can
enforce kernel Oopses quite easily: I have large IDE disks
(but <128Gb) on both primary/secondary and run /sbin/badblocks
in parallel. On a quite new board with a 1Ghz-PIII I get
an Oops/Kernel-Panic after about 5 seconds, reproducible.

In order to exclude any crap hardware, I tried this with
three different boards and with a PDC20267 and some older
PDC20262, too. But all combinations produced some errors,
even if the slowest board (200Mhz) took about 1 hour to fail.
Interestingly the system seems to be much more sensible
to the Maxtor disk. Running two IBM disk (75G and 80G) on
both channels, it took about 20 minutes vs. 5 seconds to fail.
Tests with the on-board IDE controllers did not fail, so far.

Sorry, I can't catch the Oops messages by now. Can some of
the kernel gurus please try to reproduce this to find
if it is still a bug?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
    stueken@conterra.de        
    http://www.conterra.de/   
    (0)251-7474-501
