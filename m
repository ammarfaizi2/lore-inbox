Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289939AbSAWSBU>; Wed, 23 Jan 2002 13:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289941AbSAWSBA>; Wed, 23 Jan 2002 13:01:00 -0500
Received: from [63.140.126.166] ([63.140.126.166]:37903 "EHLO helium.inexs.com")
	by vger.kernel.org with ESMTP id <S289939AbSAWSA4>;
	Wed, 23 Jan 2002 13:00:56 -0500
Date: Wed, 23 Jan 2002 12:00:55 -0600
From: Chuck Campbell <campbell@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: campbell@neosoft.com
Subject: find a file containing a specific sector
Message-ID: <20020123120055.A14311@helium.inexs.com>
Reply-To: campbell@neosoft.com
Mail-Followup-To: Chuck Campbell <campbell@neosoft.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last 7 months, I've been getting the following error in 
/var/log/messages every night during the cron.daily execution.  I've finally
tracked it down to happening during my tripwire run, and I suspect
(based on linear time into the run, and sizes of files) the problem file
lies somwhere in /usr/lib.

The error message has been identical for months, so I assume I have a bad 
spot that is not spreading.  I'd like to find the affected file, rename it
and ignore the problem for a while longer.

If I know the sector and lbasector, can I determine the inode and/or
the actual file affected?

The error message is:

Jan 23 04:24:34 helium kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Jan 23 04:24:34 helium kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=4200315, sector=4200248 
Jan 23 04:24:34 helium kernel: end_request: I/O error, dev 16:01 (hdc), sector 4200248 

as I said before, the sector number has never changed in months.


thanks,
-chuck



-- 
ACCEL Services, Inc.| Specialists in Gravity, Magnetics |  1(713)993-0671 ph.
1980 Post Oak Blvd. |   and Integrated Interpretation   |  1(713)960-1157 fax
    Suite 2050      |                                   |
 Houston, TX, 77056 |          Chuck Campbell           | campbell@neosoft.com
                    |  President & Senior Geoscientist  |

     "Integration means more than having all the maps at the same scale!"
