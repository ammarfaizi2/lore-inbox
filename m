Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTBGBVs>; Thu, 6 Feb 2003 20:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbTBGBVs>; Thu, 6 Feb 2003 20:21:48 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:58899 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267608AbTBGBVr>;
	Thu, 6 Feb 2003 20:21:47 -0500
Date: Thu, 6 Feb 2003 17:24:34 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030206172434.A15559@beaverton.ibm.com>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1044573927.2332.100.camel@mulgrave>; from James.Bottomley@steeleye.com on Thu, Feb 06, 2003 at 05:25:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 05:25:25PM -0600, James Bottomley wrote:

> > say for sure (if this wasn't related to some SCSI subsystem change, 
> > can I just revert out this section?)
> 
> No, I'm afraid not.  That was just the elimination of those fields from
> Scsi_Cmnd so now it has to be indirect through cmnd->device.  It won't
> compile without this.
> 
> James

wli has hit this several times prior to 2.5.59 (months ago), pretty much
with any across disk IO loads. The driver sets queue depth to 1 for all
LUNs.

I modified my fsck to run in parallel (well it wasn't running any fsck's
on non-root disks before that), and am hitting hit it on a NUMAQ box.

-- Patrick Mansfield
