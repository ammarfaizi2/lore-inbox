Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbRB1Oco>; Wed, 28 Feb 2001 09:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbRB1OcZ>; Wed, 28 Feb 2001 09:32:25 -0500
Received: from shared1-qin.whowhere.com ([209.185.123.111]:34796 "HELO
	shared1-mail.whowhere.com") by vger.kernel.org with SMTP
	id <S130187AbRB1OcW>; Wed, 28 Feb 2001 09:32:22 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2001 09:32:09 -0500
From: "David Anderson" <daveanderson@eudoramail.com>
Message-ID: <HDPBFHJNMFALDAAA@shared1-mail.whowhere.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: daveanderson@eudoramail.com
X-Mailer: MailCity Service
Subject: Re: Can't compilete 2.4.2 kernel
X-Sender-Ip: 209.245.110.113
Organization: QUALCOMM Eudora Web-Mail  (http://www.eudoramail.com:80) 
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*CC daveanderson@eudoramail.com* on reply.

ln -s linux-2.4 linux 

That helps a bit.  Here's what I get now when doing 'make bzImage':

In file included from /usr/src/linux/include/linux/string.h:21,
from /usr/src/linux/include/linux/fs.h:23,
from /usr/src/linux/include/linux/capability.h:17,
from /usr/src/linux/include/linux/binfmts.h:5,
from /usr/src/linux/include/linux/sched.h:9,
from /usr/src/linux/include/linux/mm.h:4,
from /usr/src/linux/include/linux/slab.h:14,
from /usr/src/linux/include/linux/proc_fs.h:5,
from init/main.c:15:
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use in this function)
make: *** [init/main.o] Error 1


Thanks! 
--

On Wed, 28 Feb 2001 14:59:04   Xavier Ordoquy wrote:
>
>simply in /usr/src do
> ln -s linux-2.4 linux
>
>> Please CC daveanderson@eudoramail.com on your replies - I'm not on the mailing list.
>> 
>> Slackware 7.1
>> cd /usr/src
>> tar -xvyf linux-2.4.2.tar.bz2
>> mv linux linux-2.4
>> cd linux-2.4
>> make mrproper
>> make menuconfig - {selection options, etc.}
>> make dep
>> make clean
>> make bzImage
>> 
>> Get this with bzImage:
>> 
>> gcc -Wall -Wstrict-prototypes -O2- fomit-frame-pointer -o scripts/split-include scripts/split-include.c
>> In file included from /usr/include/errno.h:36,
>> from scripts/split-include.c:26:
>> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
>> make: *** [scripts/split-include] Error 1
>> 
>> 
>> THANKS!
>> 
>> 
>> Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
>> 
>
>---
> Xavier Ordoquy,
> Aurora-linux, http://www.aurora-linux.com
>
>


Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
