Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTEFSz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTEFSz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:55:56 -0400
Received: from lakemtao01.cox.net ([68.1.17.244]:25277 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP id S264026AbTEFSzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:55:55 -0400
Message-ID: <3EB80817.4040807@cox.net>
Date: Tue, 06 May 2003 14:08:07 -0500
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

I added more SCSI logging support so the below is better info than the 
above. Sorry. Forgot the logging when I posted this. I knew it looked 
extra weird.

sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
sda: Write Protect is off
  sda: I/O error: dev 08:00, sector 0
  I/O error: dev 08:00, sector 0
  unable to read partition table
Device not ready.  Make sure there is a disc in the drive.

Hope this helps more.

Thanks,
David

