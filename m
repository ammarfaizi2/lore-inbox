Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVERV0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVERV0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVERV0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:26:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21428 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262385AbVERV0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:26:17 -0400
Message-ID: <428BB335.9060204@tmr.com>
Date: Wed, 18 May 2005 17:27:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "loop device recursion avoidance" patch causes difficulties
References: <73e1f59805051704216bc4c78f@mail.gmail.com>
In-Reply-To: <73e1f59805051704216bc4c78f@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luboš Doležel wrote:
> Hello,
> 
> I've created a bugreport at http://bugme.osdl.org/show_bug.cgi?id=4472
> and I was advised to write to this list.
> 
> A patch called "loop device recursion avoidance" which appeared in
> 2.6.11 kernel has complicated ISO image mounting from another mounted
> media.
> 
> Example:
> 
> # mount /mnt/dvd
> # mount -o loop /mnt/dvd/file.iso /somedir
> 
> The mount command produces this error: "ioctl: LOOP_SET_FD: Invalid argument".
> 
> This operation maybe is a kind of recursion but I think that recursion
> should be limited - not disabled.
> Now I have to copy the ISO image to my hdd before mounting. I used to
> put CD backups on DVDs; now it's more complicated to use.

Far worse than complicated, it just doesn't work... I'm glad you found 
this before I did, I have loads of similar things, created when a number 
  of small system were decomissioned and each partition was written raw 
as a file. Like:
   machineA/part1
   machineA/part2
   machineB/part1
and similar. These were all 525MB drives, but the data is moderately 
critical. I've been successful mounting with all older kernel, except 
the SysVR4 images, which have a filesystem Linux can't handle (from 
Dell's brief adventure with SysVR4). Now it appears that I will have to 
copy the data to a drive to use it, which is a minor pain since the 
process is in scripts.

Another case of fixing a problem without completely understanding it, I 
fear. At least one machine had a partition with floppy images, I hope 
they weren't loop mounting them, although it's likely they just burn a 
fresh floppy when needed (boot disks for control PCs).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
