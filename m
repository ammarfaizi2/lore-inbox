Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314393AbSDZWo5>; Fri, 26 Apr 2002 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSDZWo4>; Fri, 26 Apr 2002 18:44:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15883 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314393AbSDZWo4>; Fri, 26 Apr 2002 18:44:56 -0400
Message-ID: <3CC9C9BF.7010409@evision-ventures.com>
Date: Fri, 26 Apr 2002 23:42:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CC904AA.7020706@evision-ventures.com> <20020426160911.GE3783@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Pavel Machek napisa?:

>>+		if (stat & READY_STAT)
>>+			printk("DriveReady ");
>>+		if (stat & WRERR_STAT)
>>+			printk("DeviceFault ");
>>+		if (stat & SEEK_STAT)
>>+			printk("SeekComplete ");
>>+		if (stat & DRQ_STAT)
>>+			printk("DataRequest ");
>>+		if (stat & ECC_STAT)
>>+			printk("CorrectedError ");
>>+		if (stat & INDEX_STAT)
>>+			printk("Index ");
>>+		if (stat & ERR_STAT)
>>+			printk("Error ");
>> 	}
>> 	printk("}");
>>-#endif	/* FANCY_STATUS_DUMPS */
>>+#endif
>> 	printk("\n");
>> 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
>> 		err = GET_ERR();
> 
> 
> I believe this is actually making it *less* readable.

It makes the waste of stack setup code and call instructions
more obvious then the former, so the chances are better that I will
come back and compactize the actually generated code a bit ;-)

BTW> Redundant comments can only be false. Like the following:

#ifdef DEFINE

#endif /* DEFINE */

/*
  * some_function() is used for this and that
  */
some_function()
{
	for (;;)
	{
	} /* for */
} /* some_function() */



