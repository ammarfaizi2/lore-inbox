Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTL2CJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTL2CJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:09:51 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:39400 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262427AbTL2CJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:09:47 -0500
Message-ID: <3FEF8CFD.7060502@rackable.com>
Date: Sun, 28 Dec 2003 18:10:05 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
References: <20031228180424.GA16622@mail-infomine.ucr.edu>
In-Reply-To: <20031228180424.GA16622@mail-infomine.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2003 02:09:46.0104 (UTC) FILETIME=[D495EF80:01C3CDB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Ruscheinski wrote:

> Hi,
> 
> We're looking for a low-cost high-reliability IDE RAID solution that works well
> with the 2.6.x series of kernels.  We have about 1 TB (8 disks) that we'd
> like to access in a non-redundant raid mode.  Yes, I know, that lack of
> redundancy and high reliability are contradictory.  Let's just say that
> currently we lack the funding to do anything else but we may be able to obtain
> more funding for our disk storage needs in the near future.


   It really depends on what you mean by low cost?  The ony ide raid 
controller that does 8 PATA drives well under linux is the 3ware 
controller.  For SATA drives you have the 3ware, and adaptec controller. 
    In theroy the highpoint 8 port sata card would be a good canidate 
for software raid, but highpoint has yet to cough up an open source 
drive yet.

   It you want to go the software raid route and have 2 spare pci solts. 
  You can go with either the high point rocket raid 454 (PATA), or the 
promise SATA150 TX4.

   I really don't recommend any of promise's cards that use use the i2o 
driver, or any sort of binary only driver.

PS- Why not at least run software raid 5?  It takes far less cpu than 
you'd think, and can save your ass.
