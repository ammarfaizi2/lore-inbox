Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTBGBvg>; Thu, 6 Feb 2003 20:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBGBvg>; Thu, 6 Feb 2003 20:51:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19179 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267376AbTBGBvf>; Thu, 6 Feb 2003 20:51:35 -0500
Date: Thu, 06 Feb 2003 18:01:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Patrick Mansfield <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@steeleye.com>
cc: mikeand@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <293060000.1044583265@[10.10.2.4]>
In-Reply-To: <20030206172434.A15559@beaverton.ibm.com>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > say for sure (if this wasn't related to some SCSI subsystem change, 
>> > can I just revert out this section?)
>> 
>> No, I'm afraid not.  That was just the elimination of those fields from
>> Scsi_Cmnd so now it has to be indirect through cmnd->device.  It won't
>> compile without this.
>> 
>> James
> 
> wli has hit this several times prior to 2.5.59 (months ago), pretty much
> with any across disk IO loads. The driver sets queue depth to 1 for all
> LUNs.
> 
> I modified my fsck to run in parallel (well it wasn't running any fsck's
> on non-root disks before that), and am hitting hit it on a NUMAQ box.

Curious. I've no idea why the changes brought this out then ... I've done
hundreds and hundreds of reboots on 2.5 on all sorts of different kernels,
and never, ever seen this. Yet in 2.5.59-bk I see it every single time.
Very odd.

M.

