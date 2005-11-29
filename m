Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVK2U1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVK2U1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVK2U1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:27:20 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:51547 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932380AbVK2U1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:27:19 -0500
Message-ID: <438CAA7B.2030500@tmr.com>
Date: Tue, 29 Nov 2005 14:22:35 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too many disks in system? (RAID5)
References: <20051128222558.GN2529@mail.muni.cz> <20051128223623.GA3803@csclub.uwaterloo.ca>
In-Reply-To: <20051128223623.GA3803@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Mon, Nov 28, 2005 at 11:25:58PM +0100, Lukas Hejtmanek wrote:
> 
>>Hello,
>>
>>I have system with attached SATA array which contains 24 disks. I wanted to run
>>software RAID 5, but 24 disks means, that I would need /dev/sda to /dev/sdx
>>devices with major 8 and last minor 384. Minor seems to be limited to 8 bits.
>>Is there any chance to run software array using all 24 disks?
>>
>>My test was with mknod v. 5.2.1 and kernel 2.6.14.3
> 
> 
> Major 8 is not the only scsi major.  Look at devices.txt in the kernel
> Documentation dir.  MAKEDEV also usually knows how to make more scsi
> devices.  For example major 65.  Just use MAKEDEV /dev/sdx and see what
> it creates.

Does udev not know how to handle this?
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

