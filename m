Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSFXRsj>; Mon, 24 Jun 2002 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSFXRsi>; Mon, 24 Jun 2002 13:48:38 -0400
Received: from [212.18.235.100] ([212.18.235.100]:13697 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S314546AbSFXRsh>; Mon, 24 Jun 2002 13:48:37 -0400
From: kernel@street-vision.com
Message-Id: <200206241748.g5OHmXl11626@tench.street-vision.com>
Subject: Re: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map
To: andrew.grover@intel.com (Grover, Andrew)
Date: Mon, 24 Jun 2002 17:48:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com> from "Grover, Andrew" at Jun 24, 2002 10:35:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's a matter of where to draw the line. Obviously when we're talking
> physical devices, my tcpip connection to www.yahoo.com is not one. My PS/2
> port is. I actually think keeping in mind that driverfs is for power
> management can help delineate what should be in driverfs and what shouldn't.
> With technologies like USB, infiniband, NFS, iSCSI, and 1394, it's tough,
> but the main question should be:
> 
> "If my computer suspends, should this device be turned off?" Which is
> another way of asking is the use of a device exclusive to a particular
> machine.
> 
> If a device can be accessed by multiple machines concurrently, it should not
> be in driverfs.

That is rather confusing with respect to 1394. You should log out of sbp2
devices, but they can still be shared. Basically 1394 is shared though, and
other types of device dont have logins. So you should probably exclude it.
But anything with disks on at least wants the device flushed before sleeping,
and probably unmounted in many cases.

Justin
