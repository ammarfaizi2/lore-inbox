Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264656AbRFYQCo>; Mon, 25 Jun 2001 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbRFYQCe>; Mon, 25 Jun 2001 12:02:34 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:44043 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S264656AbRFYQCU>; Mon, 25 Jun 2001 12:02:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac12 kernel oops
In-Reply-To: <9h7mbt$p2b$1@ns1.clouddancer.com>
In-Reply-To: <32526.993483712@ocs3.ocs-net> Your message of    "Mon, 25 Jun 2001 08:15:49 MST."    <20010625151549.7ED6F784D9@mail.clouddancer.com> <9h7mbt$p2b$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010625160219.84967784D9@mail.clouddancer.com>
Date: Mon, 25 Jun 2001 09:02:19 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>On Mon, 25 Jun 2001 08:15:49 -0700 (PDT), 
>klink@clouddancer.com (Colonel) wrote:
>>ksymoops 2.4.1 on i686 2.4.5-ac12.  Options used
>>Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01aad00, System.map says c014cba0.  Ignoring ksyms_base entry
>>Why the symbol mismatch?
>
>The mismatch is caused by two variables called partition_name.  What
>does 'nm vmlinux | grep partition_name' show?  Probably one

Can't run that, but : 

grep "partition_name" System.map-2.4.5-ac12 
00000000c014cba0 t partition_name
00000000c01aad00 T partition_name


>partition_name at c01aad00 and another at c014cba0.  Both
>fs/partitions/msdos.c and drivers/md/md.c define that symbol, md

and I have both in the kernel.

>exports its version.  A good reason why exported symbols should have
>unique names.

Only the raid5 was active, the msdos stuff is a module for 'just in
case'.  Something else triggered this, I've run raid for a long time
without problems.



>>Why ignore /proc over the System.map?
>
>ksymoops has a hierarchy of trust.  System.map is more trustworthy than
>/proc/ksyms because ksyms changes, especially if you rebooted after the
>oops and before running ksymoops.

Hmm, I would have thought that /proc was more up to date, because it
would reflect changes.  No reboot, never even considered it (I've
rescued too many junior sysadmins that think rebooting is _the_ answer).




-- 
"Or heck, let's just make the VM a _real_ Neural Network, that self
trains itself to the load you put on the system. Hideously complex and
evil?  Well, why not wire up that roach on the floor, eating that stale
cheese doodle. It can't do any worse job on VM that some of the VM
patches I've seen..."  -- Jason McMullan

ditto
