Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVEHOUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVEHOUU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 10:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVEHOUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 10:20:20 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:53853
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262873AbVEHOUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 10:20:09 -0400
Message-ID: <427E2012.4040608@ev-en.org>
Date: Sun, 08 May 2005 15:20:02 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: oprofile: enabling cpu events
References: <20050508072038.24894.qmail@web60512.mail.yahoo.com>
In-Reply-To: <20050508072038.24894.qmail@web60512.mail.yahoo.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There should be a similar case there for PPro machines, and you might 
have something other than an Intel Xeon.

The best route to solve your problem is the oprofile irc channel, you 
can find its details in the oprofile website.

Baruch

li nux wrote:
> Thanks Baruch,
> But, I am still hitting the same issue.
> I am using SuSE 2.6.5, but oprofile code looks
> similar.
> so i manually made that small change from if
> (cpu_model > 3) to if (cpu_model > 100), and did a
> make modules and make modules_install.
> Then inserted the fresh oprofile module.
> # opcontrol --setup  --event=CPU_CLK_UNHALTED
>  You cannot specify any performance counter events
>  because OProfile is in timer mode.
> 
> --- Baruch Even <baruch@ev-en.org> wrote:
> 
>>The patch that worked for me against 2.6.6 is
>>attached.
>>
>>Baruch
>>
>>> arch/i386/oprofile/nmi_int.c |    2 +-
>>
>> 1 files changed, 1 insertion(+), 1 deletion(-)
>>
>>Index: 2.6.6/arch/i386/oprofile/nmi_int.c
>>
> 
> ===================================================================
> 
>>--- 2.6.6.orig/arch/i386/oprofile/nmi_int.c
>>+++ 2.6.6/arch/i386/oprofile/nmi_int.c
>>@@ -313,7 +313,7 @@ static int __init p4_init(void)
>> {
>> 	__u8 cpu_model = current_cpu_data.x86_model;
>> 
>>-	if (cpu_model > 3)
>>+	if (cpu_model > 100)
>> 		return 0;
>> 
>> #ifndef CONFIG_SMP
>>
> 
> 
> 
> 
> 		
> Yahoo! Mail
> Stay connected, organized, and protected. Take the tour:
> http://tour.mail.yahoo.com/mailtour.html
> 

