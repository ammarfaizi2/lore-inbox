Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTDPDTS (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 23:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTDPDTS 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 23:19:18 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:1221 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264215AbTDPDTR (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 23:19:17 -0400
Message-ID: <3E9CCE5A.30708@myrealbox.com>
Date: Tue, 15 Apr 2003 20:30:34 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4a) Gecko/20030415
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <fa.chdor2j.u72387@ifi.uio.no> <fa.gs8uudl.196640l@ifi.uio.no> <3E9C8FE2.8040001@myrealbox.com> <20030415162515.A362@beaverton.ibm.com>
In-Reply-To: <20030415162515.A362@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:
> On Tue, Apr 15, 2003 at 04:04:02PM -0700, walt wrote:
> 
> 
>>Yes!  Thank you.  This patch fixes the segfault of modprobe that I've 
>>been seeing for ages.
>>
>>Note that the problems I have been seeing are completely different from 
>>Geert's problems.  I have had no problems mounting a FAT-16 fs with the 
>>2.5.x kernels but modprobe has been segfaulting all along, even though 
>>the ppa module works fine for me once it has been loaded.
> 
> 
> The other problem seems to be for removable media. Is your parallel zip
> have removable media and does the boot/dmesg output from sd attach show it
> as such? I haven't used a zip drive, I thought they had to be marked
> removable.

Seems to be:

ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Found device at ID 6, Attempting to use SPP
ppa: Communication established with ID 6 using SPP
scsi0 : Iomega VPI0 (ppa) interface
   Vendor: IOMEGA    Model: ZIP 100           Rev: C.18
   Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
  /dev/scsi/host0/bus0/target6/lun0: p4
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
               ^^^^^^^^^

