Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271709AbRHQRj3>; Fri, 17 Aug 2001 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRHQRjT>; Fri, 17 Aug 2001 13:39:19 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:772 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S271709AbRHQRjN>;
	Fri, 17 Aug 2001 13:39:13 -0400
Message-Id: <200108171739.f7HHdJI98344@aslan.scsiguy.com>
To: thobi <th55@gmx.de>
cc: leroyljr@ccsi.com, linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver 
In-Reply-To: Your message of "Fri, 17 Aug 2001 19:31:40 +0200."
             <3B7D54FC.C9864DEC@gmx.de> 
Date: Fri, 17 Aug 2001 11:39:19 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>leroyljr wrote:
>> 
>> If nobody has brought this up yet, I want to report this issue.
>> 
>> Here is what happened when I tried to build the aic7xxx driver for 2.4.9:
>> 
>> aicasm/aicasm_scan.l: In function `yylex':
>> aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function
>)
>> aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
>> aicasm/aicasm_scan.l:115: for each function it appears in.)
>> aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this function)
>
>If I remember correctly I got this one when I used bison -y instead of
>yacc -
>although they are supposed to do the same. 
>
>It's just a guess - correct me if I'm telling crap

There's a missing dependency somewhere, so the y.tab.h file is stale.
If you go into drivers/scsi/aic7xxx/aicasm and do a make clean, the
build will work for you.

I'm still trying to figure out exactly what I need to put in the Makefile
to force make to run yacc/bison prior to compiling the scan file.

--
Justin
