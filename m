Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319076AbSIJHwn>; Tue, 10 Sep 2002 03:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319071AbSIJHwn>; Tue, 10 Sep 2002 03:52:43 -0400
Received: from rj.SGI.COM ([192.82.208.96]:62147 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319070AbSIJHwm>;
	Tue, 10 Sep 2002 03:52:42 -0400
Date: Tue, 10 Sep 2002 00:55:58 -0700 (PDT)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10209100055.ZM65139@classic.engr.sgi.com>
In-Reply-To: Patrick Mansfield <patmans@us.ibm.com>
        "Re: [RFC] Multi-path IO in 2.5/2.6 ?" (Sep  9,  5:08pm)
References: <patmans@us.ibm.com> 
	<200209091734.g89HY5p11796@localhost.localdomain> 
	<20020909170847.A24352@eng2.beaverton.ibm.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Patrick Mansfield <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 9,  5:08pm, Patrick Mansfield wrote:
> 
> You can have multiple initiators on FCP or SPI, without dual controllers
> involved at all. Most of my multi-path testing has been with dual
> ported FCP disk drives, with multiple FCP adapters connected to a
> switch, not with disk arrays (I don't have any non-failover multi-ported
> disk arrays available, I'm using a fastt 200 disk array); I don't know the
> details of the drive controllers for my disks, but putting multiple
> controllers in a disk drive certainly would increase the cost.


Is there any plan to do something for hardware RAIDs in which two different
RAID controllers can get to the same logical unit, but you pay a performance
penalty when you access the lun via both controllers?  It seems to me that
all RAIDs that don't require a command to switch a lun from one to the
other controller (i.e. where both ctlrs can access a lun simultaneously)
pay a performance penalty when you access a lun from both.

Working around this in a generic way (i.e. without designation by the
system admin) seems difficult, so I'm wondering what may have been done
with this (my reading of this discussion is that it has not been tackled
yet).

thanks

jeremy
