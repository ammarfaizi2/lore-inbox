Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbSK1WiL>; Thu, 28 Nov 2002 17:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSK1WiK>; Thu, 28 Nov 2002 17:38:10 -0500
Received: from dial-ctb03115.webone.com.au ([210.9.243.115]:8708 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S266804AbSK1WiJ>;
	Thu, 28 Nov 2002 17:38:09 -0500
Message-ID: <3DE69CA7.5070601@cyberone.com.au>
Date: Fri, 29 Nov 2002 09:45:59 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1,2 + ext3 data=journal: data loss on unmount
References: <C1126026D9293645B970FB72C66907961F53EE@rdmail.cit.act.edu.au> <1038502327.10021.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Thu, 2002-07-18 at 07:12, Piggin, Nick wrote:
>
>>mount /mnt/backup
>>tar cvf $FILENAME directory
>>bzip2 $FILENAME
>>umount /mnt/backup
>>
>>Upon remounting and inspection, the resulting bzip2 file is corrupted every
>>time. Adding a sync after bzip2 corrects the problem.
>>
>
>That sounds like a bug in the core code somewhere since the flush should
>have happened automatically on umount. Does 2.4.19 proper show this on
>your box (or 2.4.20-rc) ? [I'd suspect yes but would like to be sure]
>
>
For those that don't remember, $FILENAME is in /mnt/backup and
it was 100% repeatable (ie. a data corruption bug). Alan,
unfortunately I can't do a lot of testing with the box now. I
might be able to give it a try when 2.4.20 comes out, or someone
else might be able to. Directory was only a meg or two IIRC
so it shouldn't be much hasstle for someone with a spare ext3
partition.

Nick

