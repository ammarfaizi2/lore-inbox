Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbTCGWtx>; Fri, 7 Mar 2003 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbTCGWtx>; Fri, 7 Mar 2003 17:49:53 -0500
Received: from rhea.tiscali.nl ([195.241.76.178]:64909 "EHLO rhea.tiscali.nl")
	by vger.kernel.org with ESMTP id <S261835AbTCGWtv>;
	Fri, 7 Mar 2003 17:49:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Frans Pop <aragorn@tiscali.nl>
To: linux-kernel@vger.kernel.org
Subject: PATCH for ide-tape driver
Date: Sat, 8 Mar 2003 00:00:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: gadio@netvision.net.il, zaitcev@redhat.com, stern@rowland.harvard.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030307230024.6C544429D2@rhea.tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing problems with this driver.
When I do 'tar cf /dev/tape --verify <filespec>', I consistently get an error 
message 'Unexpected EOF in archive'.
I have Googled for this problem and found others have it to, but no sulution 
available.

I also tried the scsi-ide driver, but this produced errors as well, so I 
decided to try to debug the ide-tape driver.

My system is a Compaq Deskpro Pentium 300 with Debian Woody 3.0r1 that I 
upgraded to latest stable kernel 2.4.21-pre4 to work on this patch.
My tape drive is a Conner CCT-8000A (TR-4).
I have tested and created the patch working from v1.17c of ide-tape.c.

I have created a patch after fairly extensive debugging and testing.
During this process I found 2 technical bugs in the driver that I fixed also. 
These bugs produced the following log messages:
- bug: nr_stages should be 0 now
- ide-tape pipeline bug: first_stage 00000000, next_stage 00000000, 
last_stage 00000000, nr_stages 1

I have created a website at http://home.tiscali.nl/isildur/ where the patch 
can be downloaded. On this site I have documented quite extensively what I 
have done.

IMO there seem to be some important discrepancies in the way file spacing is 
handled in the kernel and the way it is used in tar and mt. This is also 
documented on the website.

I am currently looking for feedback and people to test my patch.

TIA,

Frans Pop

P.S. Please reply with CC to private mail as I am not on the list.
