Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbTBCHCs>; Mon, 3 Feb 2003 02:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTBCHCs>; Mon, 3 Feb 2003 02:02:48 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:8624 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S266006AbTBCHCr>; Mon, 3 Feb 2003 02:02:47 -0500
Message-ID: <3E3E1643.2080807@bogonomicon.net>
Date: Mon, 03 Feb 2003 01:12:03 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
References: <20030202223009.GA344@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a file system that is designed for use on FLASH devices.  In general 
FLASH devices are not very useable for systems that need to modify data 
on the disk often.

You may wish to look at the virtual memory file system available in the 
kernel if you have enough RAM.  You would mount your CompactFlash device 
read only and have all updates go to the virtual memory filesystem. 
When you want to commit the changes, remount the CompactFlash read/write 
and save the changes then remount it read only.

You would be surprised how fast a million writes can happen on a disk.

- Bryan

Pavel Machek wrote:
> Hi!
> 
> I had compactflash from Apacer (256MB), and it started corrupting data
> in few months, eventually becoming useless and being given back for
> repair. They gave me another one and it is just starting to corrupt
> data.
> 
> First time I repartitioned it; now I only did mke2fs, and data
> corruption can be seen by something as simple as
> 
> cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.
> 
> [Fails 1 in 5 tries].
> 
> Anyone seen something similar? Are there some known-good
> compactflash-es?
> 
> 								Pavel


