Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSIBGqe>; Mon, 2 Sep 2002 02:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSIBGqe>; Mon, 2 Sep 2002 02:46:34 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:5545 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id <S317517AbSIBGqd>; Mon, 2 Sep 2002 02:46:33 -0400
Date: Mon, 02 Sep 2002 09:51:05 +0200
From: Gil Disatnik <Jewnix@technohac.com>
Subject: Promise PDC20276 & 2.2.19
To: linux-kernel@vger.kernel.org
Message-id: <5.1.0.14.2.20020902094221.00b4e918@mail.netvision.net.il>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am trying to get this onboard raid controller to work on a linux machine 
that runs 2.2.19,

I recompiled my own kernel with the following options enabled:

"Support Promise software RAID (Fasttrak(tm))"

It didn't work and dmesg showd:
"Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found"

I then added just in case:
PROMISE PDC202{46|62|65|67|68|69|70} support
Special UDMA Feature
Special FastTrak Feature

The same error, only this time it also says:
"ide: Skipping Promise RAID controller." (Before the "No raid array found" 
error)

I then manually added to the .config:

CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y

Nothing works.
Any suggestions?

P.S - if it's relevant, I have built a mirrored array, not stripped.

Thanks



Regards

Gil Disatnik
UNIX system/security administrator.

GibsonLP@EFnet

_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
"Windows NT has detected mouse movement, you MUST restart
your computer before the new settings will take effect, [ OK ]"
--------------------------------------------------------------------
Windows is a 32 bit patch to a 16 bit GUI based on a 8 bit operating
system, written for a 4 bit processor by a 2 bit company which can
not stand 1 bit of competition.
-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

