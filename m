Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHaDMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHaDMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 23:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUHaDMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 23:12:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2217 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266341AbUHaDMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 23:12:31 -0400
Date: Mon, 30 Aug 2004 18:17:24 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Driver retries disk errors.
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <002e01c48eef$e3e2dc40$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.d48te6f.1ol6tbb@ifi.uio.no> <fa.eti1vu1.2nqlj5@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite likely, in that case the drive has exhausted its spare pool, and there 
are a bunch of bad sectors that have already been reallocated. Some drives 
will reallocate sectors if they are still readable but the sector appears to 
be marginal.


----- Original Message ----- 
From: "Rogier Wolff" <R.E.Wolff@harddisk-recovery.nl>
Newsgroups: fa.linux.kernel
To: "Theodore Ts'o" <tytso@mit.edu>; <linux-kernel@vger.kernel.org>; 
<linux-ide@vger.kernel.org>
Sent: Monday, August 30, 2004 4:19 PM
Subject: Re: Driver retries disk errors.


> On Mon, Aug 30, 2004 at 01:46:32PM -0400, Theodore Ts'o wrote:
>> > a filesystem: if we recover one block this way, the next block will be
>> > errorred and the filesystem "crashes" anyway. In fact this behaviour
>> > may masquerade the first warnings that something is going wrong....
>>
>> If the block gets successfully read after 2 or 3 tries, it might be a
>> good idea for the kernel to automatically do a forced rewrite of the
>> block, which should cause the disk to do its own disk block
>> sparing/reassignment.
>
> Hi Ted,
>
> I agree that this is the theory. In practise however, I've never
> seen it work correctly. We've seen several disks with say 1-5 bad
> blocks and nothing else, and "dd if=/dev/zero of=/dev/<disk>" doesn't
> seem to cure them.
>
> Roger.
>
> -- 
> +-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
> | Files foetsie, bestanden kwijt, alle data weg?!
> | Blijf kalm en neem contact op met Harddisk-recovery.nl!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

