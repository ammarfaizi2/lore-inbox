Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTEFSlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTEFSlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:41:03 -0400
Received: from lakemtao01.cox.net ([68.1.17.244]:3246 "EHLO lakemtao01.cox.net")
	by vger.kernel.org with ESMTP id S264028AbTEFSk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:40:56 -0400
Message-ID: <3EB80495.2070808@cox.net>
Date: Tue, 06 May 2003 13:53:09 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] Zipdrive messages too much
References: <Pine.LNX.3.96.1030506141927.9452A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030506141927.9452A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Wed, 23 Apr 2003, David van Hoose wrote:
> 
>>I included ppa and scsi in my kernel since I have a parallel port 
>>zipdrive. Problem I am having is that it keeps scanning the drive for 
>>too much too often. Anytime I mount/unmount, plug/unplug USB and 
>>firewire devices, or at random times, I get the following messages on my 
>>console and in my messages file.
> 
> Was the zip drive recognized as removable?

Yes it was. Below is the snip-it from my dmesg. That is also where the 
first error appears. Though it is different in subsequent with the last 
line as can be seen in the quoted message fragment just below this part.

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi1 : Iomega VPI0 (ppa) interface
   Vendor: IOMEGA    Model: ZIP 100           Rev: D.09
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
  sda: I/O error: dev 08:00, sector 0
  I/O error: dev 08:00, sector 0
  unable to read partition table

>>Apr 23 11:41:35 aeon kernel: sda : READ CAPACITY failed.
>>Apr 23 11:41:35 aeon kernel: sda : status = 1, message = 00, host = 0, 
>>driver = 08
>>Apr 23 11:41:35 aeon kernel: Current sd00:00: sns = 70  2
>>Apr 23 11:41:35 aeon kernel: ASC=3a ASCQ= 0
>>Apr 23 11:41:35 aeon kernel: Raw sense data:0x70 0x00 0x02 0x00 0x00 
>>0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 
>>0xfe 0x01 0x00 0x00 0x00 0x00
>>Apr 23 11:41:35 aeon kernel: sda : block size assumed to be 512 bytes, 
>>disk size 1GB.
>>Apr 23 11:41:35 aeon kernel: sda: Write Protect is off
>>Apr 23 11:41:35 aeon kernel:  sda: I/O error: dev 08:00, sector 0
>>Apr 23 11:41:35 aeon kernel:  I/O error: dev 08:00, sector 0
>>Apr 23 11:41:35 aeon kernel:  unable to read partition table
>>Apr 23 11:41:35 aeon kernel: Device not ready.  Make sure there is a 
>>disc in the drive.
>>
>>This gets really annoying, but I like to use my zipdrive.
>>Let me know if more information is needed.

It works nice under 2.5.x, but gives the sda error 5+ times just during 
boot under 2.4.x. I wonder if someone forgot to backport all or some 
patches.

Thanks,
David

