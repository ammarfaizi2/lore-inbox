Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263402AbSJFMVB>; Sun, 6 Oct 2002 08:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbSJFMVB>; Sun, 6 Oct 2002 08:21:01 -0400
Received: from [203.117.131.12] ([203.117.131.12]:32651 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S263402AbSJFMU7>; Sun, 6 Oct 2002 08:20:59 -0400
Message-ID: <3DA02BF2.2040506@metaparadigm.com>
Date: Sun, 06 Oct 2002 20:26:26 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: jbradford@dial.pipex.com, GrandMasterLee <masterlee@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
References: <200210061103.g96B3mlO001484@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I see. ATM I'm using 2.4.19, but would like to get to 2.4.20, because of
>>the TG3 fixes. 
> 
> 
> You were probably thinking of CONFIG_SCSI_MULTI_LUN above, then.  That causes the kernel to probe all LUNs instead of just LUN 0, which is the default due to a lot of broken devices to respond to all LUNs instead of just LUN 0.  The sparse LUN option is in addition to that in 2.5.x.
> 
> If this is for a live server, it might be easiest to hard code the LUNs you need it to probe in to 2.4.x for now, and wait until 2.6.x for proper support.

2.4 supports sparse lun scanning, although it is not enabled
dynamically and requires add a BLIST_SPARSELUN flag for your device
in the device_list array in drivers/scsi/scsi_scan.c

You just need to get the Vendor and Model info from /proc/scsi/scsi

I am using qlogic 2300s with sparse luns working fine on 2.4.18.

~mc

