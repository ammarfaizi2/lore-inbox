Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314842AbSEPW3u>; Thu, 16 May 2002 18:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSEPW3t>; Thu, 16 May 2002 18:29:49 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:8454 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314842AbSEPW3s>;
	Thu, 16 May 2002 18:29:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: TProvoni@aol.com
Cc: martillo@telfordtools.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, linux@auroratech.com,
        frank@auroratech.com
Subject: Re: 2.4.19-pre8 non-kernel files in wan/8253x 
In-Reply-To: Your message of "Thu, 16 May 2002 11:07:15 EDT."
             <141.e9270f3.2a152523@aol.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 May 2002 08:29:34 +1000
Message-ID: <2888.1021588174@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002 11:07:15 EDT, 
TProvoni@aol.com wrote:
>In a message dated 5/16/2002 3:57:52 AM Eastern Daylight Time, 
>kaos@ocs.com.au writes:
>> drivers/net/wan/8253x/Makefile contains these lines
>> 
>> 8253xcfg: 8253xcfg.c
>>         $(CC)  -o 8253xcfg $(EXTRA_CFLAGS) -U__KERNEL__ 8253xcfg.c
>> 
>> 8253xmac: 8253xmac.c
>>         $(CC)  -o 8253xmac $(EXTRA_CFLAGS) -U__KERNEL__ 8253xmac.c
>> 
>> 8253xspeed: 8253xspeed.c
>>         $(CC)  -o 8253xspeed $(EXTRA_CFLAGS) -U__KERNEL__ 8253xspeed.c
>> 
>> 8253xpeer: 8253xpeer.c
>>         $(CC)  -o 8253xpeer $(EXTRA_CFLAGS) -U__KERNEL__ 8253xpeer.c
>> 
>> eprom9050: eprom9050.c
>>         $(CC)  -o eprom9050 $(EXTRA_CFLAGS) -U__KERNEL__ eprom9050.c
>> 
>> All of those .c files are user space utilities, they do not fit the
>> kernel build system and do not belong in the kernel.  Please move these
>> files to a separate user space package and delete from 2.4.19-pre*.
>
>I think there needs to be some way to guarantee that these last two programs
>are available whenever the driver is included with a kernel.

User space programs do not belong in the kernel.  They belong in a user
space package, like all the other device tuning programs.  The kernel
documentation for your driver points to the user space package.

