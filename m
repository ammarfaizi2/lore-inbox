Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbTFLUHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbTFLUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:07:49 -0400
Received: from devil.servak.biz ([209.124.81.2]:51649 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264977AbTFLUHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:07:48 -0400
Subject: Re: SBP2 hotplug doesn't update /proc/partitions
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@digeo.com>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1055446080.3480.291.camel@torrey.et.myrio.com>
References: <1054770509.1198.79.camel@torrey.et.myrio.com>
	 <3EDE870C.1EFA566C@digeo.com>
	 <1054838369.1737.11.camel@torrey.et.myrio.com>
	 <20030605175412.GF625@phunnypharm.org>
	 <1054858724.3519.19.camel@torrey.et.myrio.com>
	 <20030606025721.GJ625@phunnypharm.org>
	 <1055446080.3480.291.camel@torrey.et.myrio.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055449280.1789.28.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Jun 2003 13:21:21 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is perhaps a related problem:  I just noticed that if I have a
firewire drive plugged in at boot, the SBP2 driver detects it during
boot:

ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e8201000-e82017ff]  Max Packet=[2048]
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 4  Model: A250J8            Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 06
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0004830000002cb3]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0040630000001c47]

But, the drive itself (/dev/sda) and any partitions on it don't show up
in /proc/partitions until I mount one of them or perform some sort of
other access to the drive, like running fdisk on it.  

To me, this seems to be a bug.  Or is it actually by design?

-- 
Torrey Hoffman <thoffman@arnor.net>

