Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTFLTy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFLTy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:54:27 -0400
Received: from devil.servak.biz ([209.124.81.2]:9409 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264971AbTFLTy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:54:26 -0400
Subject: Re: SBP2 hotplug doesn't update /proc/partitions
From: Torrey Hoffman <thoffman@arnor.net>
To: andersen@codepoet.org
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612195209.GA5029@codepoet.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com>
	 <3EDE870C.1EFA566C@digeo.com>
	 <1054838369.1737.11.camel@torrey.et.myrio.com>
	 <20030605175412.GF625@phunnypharm.org>
	 <1054858724.3519.19.camel@torrey.et.myrio.com>
	 <20030606025721.GJ625@phunnypharm.org>
	 <1055446080.3480.291.camel@torrey.et.myrio.com>
	 <20030612195209.GA5029@codepoet.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055448472.1789.13.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Jun 2003 13:07:52 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 12:52, Erik Andersen wrote:
...
> > fdisk /dev/sda believes the drive is only 120 GB but has a single 250 GB
> > partition:
> 
> I strongly suspect your 1394 to IDE bridge is an ATA5 device, and
> is therefore limited to supporting drives less than 128 GB.  That
> is the case for my firewire drives, so I keep them populated with
> 120 GB drives and I put my 200 GB drives elsewhere....

Thanks for the tip, but no, the enclosure with the 250 GB drive does
support ATA 6.  However, the other enclosure with the 120 GB drive is
ATA 5 only. 

After rebooting, I am able to mount the 250 GB reiserfs partition, 
and I'm pretty sure that reiserfs accesses data past the 120 GB boundary
during the mount process.  (I only have 8 GB of data on the partition at
the moment though...)

More bug reports on sbp2 coming in a second :-)

Torrey

