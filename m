Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSCFJxR>; Wed, 6 Mar 2002 04:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCFJxI>; Wed, 6 Mar 2002 04:53:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:65285 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293429AbSCFJw6>; Wed, 6 Mar 2002 04:52:58 -0500
Message-ID: <3C85E693.4020507@evision-ventures.com>
Date: Wed, 06 Mar 2002 10:51:15 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>, Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iPNT-0004tb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>No quite my plan is:
>>
>>1. Rip it off.
>>2. Reimplement stuff if and only if someone really shows pressure
>>for using it.
>>
>>The "command parsing" excess is certainly going to go.
>>
> 
> Its maybe handy actually. Without command parsing I can tell the drive to
> do anything without good control - you know say like all the upcoming SSSCA
> encrypt chunks of your harddisk so you can never get them back stuff.
> 
> The important bit is that for each command you must know the sequence of
> phases. Get it wrong and your storage system goes off to visit undefined
> states. I don't like my disks in undefined states because it tends to leave
> them with undefined content.
> 
> Two things I do think wants considering
> 
> #1	Can the same thing be done by passing the command and sequence of
> 	transitions from user space (scsi generic takes that approach but
> 	scsi is a little more forgiving since the bogus transition will
> 	screw your command in a "oh whoops" detectable manner). IDE
> 	has a nice habit of explaining you screwed up by scribbling on
> 	the disk and/or locking solid
> 
> #2	Shoot all the little routines and make them into a table.
> 
> That would tidy it no end. 

I will just try the aproach 2 first.

