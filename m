Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268203AbTBNB4J>; Thu, 13 Feb 2003 20:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268207AbTBNB4J>; Thu, 13 Feb 2003 20:56:09 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:56330 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S268203AbTBNB4H>;
	Thu, 13 Feb 2003 20:56:07 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A331@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.60 (3/34) AC#3
Date: Fri, 14 Feb 2003 11:05:57 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments. 

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox
Sent: 2003/02/12 23:43
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (3/34) AC#3

> On Wed, Feb 12, 2003 at 10:25:49PM +0900, Osamu Tomita wrote:
>> +ifneq ($(CONFIG_PC9800),y)
>>  obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
>> +else
>> +obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
>> +endif
> 
> Please use a different config option for your floppy driver, i.e.
> CONFIG_BLK_DEV_FD98
I'll do that way.

>> +#if !defined(CONFIG_PC9800) && !defined(CONFIG_PC98)
>> +#error This driver works only for NEC PC-9800 series
>> +#endif
> 
> this shoiuld be handled by the config system..
> 
> > +	/* Following `TAG: INITIALIZER' notations are GNU CC extension.
*/
> +	flags:	LP_EXIST | LP_ABORTOPEN,
> +	chars:	LP_INIT_CHAR,
> +	time:	LP_INIT_TIME,
> +	wait:	LP_INIT_WAIT,
> +};
> 
> please use C99-style initializers here.

>> +		unsigned long eflags;
>> +
>> +		save_flags(eflags);
>> +		cli();		/* interrupts while check is fairly bad
*/
> 
> use proper spinlocking.
These 3 points are already in update patch (23/34).
And I'm working to fix other points in lp_old98.c.
I'll resend patches soon.

Thanks again,
Osamu Tomita
 
