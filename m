Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRKHV2t>; Thu, 8 Nov 2001 16:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRKHV2k>; Thu, 8 Nov 2001 16:28:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S278584AbRKHV2e>; Thu, 8 Nov 2001 16:28:34 -0500
Date: Thu, 8 Nov 2001 16:28:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Cotte@de.ibm.com, linux-kernel@vger.kernel.org, Linux390@de.ibm.com
Subject: Re: if (a & X || b & ~Y) in dasd.c
In-Reply-To: <20011108155749.A24023@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.95.1011108162237.192A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Pete Zaitcev wrote:

It looks okay, but it sure is hard to read. I will simplify...

> Carsten and others:
> 
> this code in 2.2.14 looks suspicious to me:
> 
> ./drivers/s390/block/dasd.c:
>         /* first of all lets try to find out the appropriate era_action */
>         if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||

          if (value & MASK ||

>             stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {

              another_value & ANOTHER_MASK )

		(if ether of these are TRUE)

... etc.
 Don't confuse & with &&....

> Are you sure any parenthesises are not needed here?

No, but they sure would help to make the code readable by humans
as well as compilers.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


