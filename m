Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSFDLr6>; Tue, 4 Jun 2002 07:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSFDLpH>; Tue, 4 Jun 2002 07:45:07 -0400
Received: from web8004.in.yahoo.com ([203.199.70.64]:11527 "HELO
	web8004.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id <S317446AbSFDLo0>; Tue, 4 Jun 2002 07:44:26 -0400
Message-ID: <20020604114421.71523.qmail@web8004.mail.in.yahoo.com>
Date: Tue, 4 Jun 2002 04:44:21 -0700 (PDT)
From: Shanks <mshanks79@yahoo.co.in>
Subject: Re: problem with <asm/semaphore.h>
To: Hossein Mobahi <hmobahi@yahoo.com>, linux-kernel@vger.kernel.org
Cc: linux-c-programming@vger.kernel.org
In-Reply-To: <20020604111944.34250.qmail@web12708.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hossein,

If you look inside <asm/semaphore.h> you will see that
the definition of struct semaphore is within a 
conditional #ifdef __KERNEL__

Hence __KERNEL__ needs to be defined for this code to
compile.
Try compiling like this
$> gcc -D__KERNEL__ file.c

Regards,
Shanks

--- Hossein Mobahi <hmobahi@yahoo.com> wrote:
> Hi
> I compiled the following code with gcc under Redhat
> 7.2 :
> #include <asm/semaphore.h>
> main()
> {
>     struct semaphore sum;
> }
> 
> It doesn't compile, saying "storage size of `sem'
> isn't known".
> 
> Sincerely
> --Hossein Mobahi

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
