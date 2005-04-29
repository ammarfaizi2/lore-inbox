Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVD2Cfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVD2Cfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 22:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVD2Cfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 22:35:32 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:5105 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262221AbVD2CfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 22:35:22 -0400
Message-ID: <42719D5D.5060106@davyandbeth.com>
Date: Thu, 28 Apr 2005 21:35:09 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
References: <4270FA5B.5060609@davyandbeth.com> <20050428200908.GB6669@thunk.org>
In-Reply-To: <20050428200908.GB6669@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Thu, Apr 28, 2005 at 09:59:39AM -0500, Davy Durham wrote:
>  
>
>>Crazy huh?  Well, I unmounted /home and did an fsck -f  on the partition 
>>and remounted it.  Then everything looked okay.
>>    
>>
>
>What messages were displayed by e2fsck?  What version of the kernel
>are you running?
>
>No, I haven't heard of any such problems with ext2/3 filesystems.
>This is the first time that someone was reported a specific problem
>with the # of blocks used accounting.  There is the standard "file
>held open so the number of blocks used is greater than blocks reported
>by du", but that won't cause df to display negative numbers.
>
>						- Ted
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Well, I don't have the output of the fsck when I did the machine I did 
it on. And I can't do it on the production machine right now.  Perhaps I 
can tommorrow if I can talk to the guys about cleaning it off.  I'm a 
bit afraid to do it, reason being that if it's off on this accounting 
information, what files/data might I lose if I did an fsck on it 
(remember, the one I already did it on was empty).

Also, I did an "e2fsck /home" on the running machine just expecting to 
get the "warning, don't do this on a mounted file system" prompt, but 
instead I got:

# e2fsck /home
e2fsck 1.34 (25-Jul-2003)
e2fsck: Is a directory while trying to open /home

The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

Perhaps it's because it is mounted? (and -b 8193 didn't change 
anything).  Do I need to do it on the device after unmounting instead? 
(Probably so)

I do get the expected warning with fsck itself.  Which should I be 
using? e2fsck or fsck?

This is kernel-2.6.3-15mdk BTW (mdk 10.0official)

I'll try to report back tomorrow if I'm able to do anything..

Thanks,
  Davy

