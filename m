Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272836AbRIGUav>; Fri, 7 Sep 2001 16:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272837AbRIGUal>; Fri, 7 Sep 2001 16:30:41 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:6097 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272836AbRIGUa2>;
	Fri, 7 Sep 2001 16:30:28 -0400
Message-ID: <3B992F7D.4E07D59B@candelatech.com>
Date: Fri, 07 Sep 2001 13:35:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Blocking v/s Non-blocking NFS (and iSCSI) file reads/writes.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on writing a program that will be used to stress test
NFS and iSCSI based file systems.  I am currently using a non-threaded,
and non-forking architecture based on non-blocking IO and select() to
do my network traffic generation.  I would like to be able to fit the
file-testing code in the same framework.  However, I'm not sure I can
make this model work with network based file systems....

So, does select() work for NFS reads?  (IE: I open a file-descriptor
on an NFS mounted file system, and start reading.  The network goes
down.  Will select() start not marking that file as read/write-able?)

If I set the file descriptor to be O_NONBLOCK, will it return immediately
if the network is down (regardless of what select told me)?

I have the same questions about an iSCSI based file system...

Does anyone have any suggestions for reading material on this topic,
other than kernel source and patches?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
