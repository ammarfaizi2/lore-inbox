Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTEEWjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEEWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:39:19 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:18361 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261548AbTEEWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:39:13 -0400
Date: Mon, 5 May 2003 18:49:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: partitions in meta devices
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305051851_MC3-1-3782-9001@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       No, it should not.  And devfs, for once, has nothing to do with it.
> RAID devices (md*) have _one_ (1) minor allocated to each.  Consequently,
> they could not be partitioned by any kernel - there is no device numbers
> to be assigned to their partitions.
>  
> > Could you please tell us which kernel version you're using?
> 
>       What would be much more interesting, which kernel are _you_ using
> and what device numbers, in your experience, do these partitions get?

 These patches appear to contain raid partitioning code of some sort:

   http://www.cse.unsw.edu.au/~neilb/patches/linux-stable/

Only the first 16 md devices can be partitioned, though... major is 60,
minors are 0-15 for md0, 16-31 for md1, etc.


