Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVCVUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVCVUja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVCVUgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:36:53 -0500
Received: from mail0.lsil.com ([147.145.40.20]:28117 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261844AbVCVUfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:35:47 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01AEB1F7@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
Subject: RE: [PATCH] - Fusion-MPT much faster as module
Date: Tue, 22 Mar 2005 13:35:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 22, 2005 12:05 PM, James Bottomley wrote:
> On Tue, 2005-03-22 at 11:40 -0700, Moore, Eric Dean wrote:
> > History on this:
> > Between the 3.01.16 and 3.01.18, we introduced new method
> > to passing command line options to the driver.  Some of the
> > command line options are used for fine tuning dv(domain
> > validation) in the driver.  By accident, these command line 
> options were
> > wrapped around #ifdef MODULE in the 3.01.18 version of the driver.
> > What this meant is when the driver is compiled built-in the kernel,
> > the optimal settings for dv were ignored, thus poor performance.  
> 
> OK, I'll add this to the queue.
> 
> Could I just point out that if your driver actually printed 
> the results
> of negotiation, this would have been an awful lot easier to debug.
> 
> Additionally, if you used the SPI transport class domain 
> validation, the
> issue wouldn't have arisen in the first place.
> 
> James
> 

Yes, I agree with you.

I'm actively working in the background to split the mptscish driver into
separate bus type drivers.  One for fiber channel, one for SCSI, and
one for eventually SAS.  This was a request from you long time back, at
a time when I tried to submitting a patch having FC transport attributes
support.
I think once I submit that, then we can start taking a looking at supporting
the SPI transport layer.  

I still wonder if the SPI transport layer will work for RAID volumes.  
Do you know if the spi transport layer supports dv on hidden devices in a
raid volume? 
Meaning these hidden physical disks will not been seen by the block layer,
however 
spi transport layer would be aware so dv can be performed those hidden disk?

Eric 






