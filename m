Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTKNVqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTKNVqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:46:48 -0500
Received: from lists.us.dell.com ([143.166.224.162]:55021 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264468AbTKNVqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:46:46 -0500
Date: Fri, 14 Nov 2003 15:44:23 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114154423.A5587@lists.us.dell.com>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au> <1068787304.4157.8.camel@localhost> <16308.26754.867801.131463@notabene.cse.unsw.edu.au> <20031114101647.GJ32211@marowsky-bree.de> <20031114182927.GA8810@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031114182927.GA8810@gtf.org>; from jgarzik@pobox.com on Fri, Nov 14, 2003 at 01:29:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This brings up a tangent point...  partitions on top of RAID are a new
> thing, which means that one has the chance to define the partition
> format.
> 
> And I kinda like EFI partition format, a lot better than the other
> common ones...

Any reason why the current partition-mapping code couldn't be extended
to handle partition detection on a generic block device (which is what
MD presents I think) instead of a struct gendisk?  Then it wouldn't
matter which scheme someone wanted to use - any scheme provided for in
the kernel (or userspace if partx were extended) could be used.

I'm partial to the EFI format too, but wouldn't want to write that
code a second time, once for normal disks, and once for md.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
