Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278310AbRJMPCj>; Sat, 13 Oct 2001 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278311AbRJMPC3>; Sat, 13 Oct 2001 11:02:29 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:1540 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278310AbRJMPCS>;
	Sat, 13 Oct 2001 11:02:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck 
In-Reply-To: Your message of "Sat, 13 Oct 2001 16:06:35 +0200."
             <3BC84A6B.C788C477@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Oct 2001 01:02:33 +1000
Message-ID: <18096.1002985353@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 16:06:35 +0200, 
Manfred Spraul <manfred@colorfullife.com> wrote:
>> I forgot to mention that both fsck.ext2 and fsck.ext3 report
>> 
>> 1: Entry 'sendmail.pid' in /var/run (686849) has
>>		deleted/unused inode 688415.  CLEARED.
>> /1: Entry 'crond.pid' in /var/run (686849) has
>>		deleted/unused inode 688416.  CLEARED.
>> /1: Entry 'xfs.pid' in /var/run (686849) has
>>		deleted/unused inode 688417.  CLEARED.
>> /1: Entry 'atd.pid' in /var/run (686849) has
>>		deleted/unused inode 688418.  CLEARED.
>> 
>All inodes are in the same sector.
>Could you try out if that sector is destroyed?

It should not matter which sector the inode is in, the directory entry
should have been cleared, independent of the inode.  But I checked
anyway, dd of the entire partition to /dev/null succeeded, no disk
error messages anywhere in the logs at any time.

