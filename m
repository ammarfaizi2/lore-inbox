Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUAMUge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUAMUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:36:22 -0500
Received: from lists.us.dell.com ([143.166.224.162]:25780 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265377AbUAMUgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:36:17 -0500
Date: Tue, 13 Jan 2004 14:35:59 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Scott Long <scott_long@adaptec.com>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed Enhancements to MD
Message-ID: <20040113143559.B7646@lists.us.dell.com>
References: <40036902.8080403@adaptec.com> <20040113081932.A721@lists.us.dell.com> <400436CC.7020007@pobox.com> <40045539.9040709@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40045539.9040709@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Jan 13, 2004 at 03:29:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 03:29:45PM -0500, Chris Friesen wrote:
> How is this different than the 20GB RAID0 and 6 15BB RAID1s that I've 
> got on two 100GB spindles right now?

Indeed, md does this with partitions on the disks today, so it is
analogous; DDF does this with disk extents, which has the same
functionality as partitions, but without an MSDOS partition table to
define the partitions, but an on-disk metadata format (yes, partition
tables are metadata too...). 

The solution needs partitions/extents in two places.
1) below the logical drive, from which logical drives are created.
2) above the logical drive, on which multiple file systems are
created.

md provides 1) today, and as discussed today patches exist to do 2)
that have not yet been merged.


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
