Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRB1VuF>; Wed, 28 Feb 2001 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRB1Vtz>; Wed, 28 Feb 2001 16:49:55 -0500
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.112]:48656 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S129283AbRB1Vto>;
	Wed, 28 Feb 2001 16:49:44 -0500
Date: Wed, 28 Feb 2001 22:48:50 +0100
From: Eduard Hasenleithner <eduardh@aon.at>
To: linux-kernel@vger.kernel.org
Subject: How to set hdparms for ide-scsi devices on devfs?
Message-ID: <20010228224850.A10608@moserv.hasi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, if this issue was already discussed in lkml. I didn't find
a reference to this at www.geocrawler.com

My Problem:
I want to set the unmaskirq and dma -flag for my ide cd-recorder.
The Problem is, that devfs creates no ide device, but only
the /dev/scsi/../{cd,general} devices are created. And hdparm
don't accepts this devices for setting the ide-parameters.

My current workaround is to create a /dev/hd? device "by hand"
at system startup. This is not very beautiful. Furthermore, if
the device numbers in devfs are deactivated, this won't work
anymore.

I can live with my current solution. But i would be very happy
if someone can present a clean solution.

I posted this message intentionally not on the devfs mailing list
as i think this problem is related to accessing the same device
through different /dev entries. Under devfs, the /dev/ide/...
device node gets allocated after the corresponding ide-xx.o has
been loaded. But this is not possible with ide-scsi claiming
the device :(

Thanks in advance

-- 
Eduard Hasenleithner
student of
Salzburg University of Applied Sciences and Technologies
