Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUHGCMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUHGCMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 22:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHGCMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 22:12:14 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:45729 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266215AbUHGCMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 22:12:13 -0400
Message-ID: <41143A35.7020700@rtr.ca>
Date: Fri, 06 Aug 2004 22:11:01 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
In-Reply-To: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>	The CAM interface (which is from the SCSI standards group)
>>>	usually is implemeted in a way that applications open /dev/cam and
>>>	later supply bus, target and lun in order to get connected
>>>	to any device on the system that talks SCSI.

This would be great!

I'm currently fussing about how my new RAID driver
(hardware assisted) can expose it's member drives
in such a way as for the userspace RAID management s/w
to be able to find them.

The driver only sees channel:device:lun, whereas in userspace
there's no tidy way to convert that to a major:minor pair.

I figure this cannot be the only situation where this is a problem.
We're hoping to resolve it all with the scsidev utility,
which is basically a kludge to work around a very inconventient
API from the kernel.  Having a /dev/cam interface as described above
would certainly help here.

What other ways to do this should I be looking at?
(common to both 2.4.xx and 2.6.xx ??)
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
