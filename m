Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282001AbRKUXze>; Wed, 21 Nov 2001 18:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282003AbRKUXzX>; Wed, 21 Nov 2001 18:55:23 -0500
Received: from woody.fsl.noaa.gov ([137.75.132.225]:37811 "EHLO
	woody.fsl.noaa.gov") by vger.kernel.org with ESMTP
	id <S282001AbRKUXzG>; Wed, 21 Nov 2001 18:55:06 -0500
Date: Wed, 21 Nov 2001 16:51:42 -0700
From: Craig Tierney <ctierney@hpti.com>
To: linux-kernel@vger.kernel.org
Subject: Question about change in scsi_scan.c
Message-ID: <20011121165142.G25204@hpti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between 2.4.12 and 2.4.14 there
was a change to scsi_scan.c that
tells the detection code to not
look for more than 8 luns if
the scsi drive type is not SCSI_3
or better. 


  /* don't probe further for luns > 7 for targets <= SCSI_2 */
if ((lun0_sl < SCSI_3) && (lun > 7))
  break;

Why????

My census raid reports SCSI_2 devices,
but I have 32 luns per controller?  Under
2.4.14 I could no longer see all of the
luns until a changed the code here.  

Why not use MAX_SCSI_LUNS?  

Thanks,
Craig

-- 
Craig Tierney (ctierney@hpti.com)
