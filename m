Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGLL7p>; Fri, 12 Jul 2002 07:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGLL7o>; Fri, 12 Jul 2002 07:59:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6917 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316070AbSGLL7n> convert rfc822-to-8bit;
	Fri, 12 Jul 2002 07:59:43 -0400
Message-ID: <3D2EC502.6030105@evision-ventures.com>
Date: Fri, 12 Jul 2002 14:01:06 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.3.96.1020711162333.5732C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bill Davidsen napisa³:
> On Thu, 11 Jul 2002, Martin Dalecki wrote:
> 
> 
>>vmstat.c:
>>
>>hz = sysconf(_SC_CLK_TCK);	/* get ticks/s from system */
>>
>>And yes I know the libproc is *evil* in this area.
>>The rest should be an implementation detail of sysconf().
> 
> 
> Yes, any of the changes need to make the dynamic value available to
> programs. Alas, too many programs grab the HZ value and compile it in, and
> don't work right on a kernel with a modified rate. I don't know if the
> CLK_TCK macro is dynamic or not, I sure hope so.
> 
> I'd like to see it set at boot time, and available in /proc/sys for easy
> use by scripts. As noted by others, there are a lot of uses in the kernel
> source which assume that arithmetic will happen at compile time, and even
> if you ignore the overhead it would take a lot of rewriting to make it
> dynamic. Setting it a boot time gets most of the gain and none of the
> pain (boot time = pick a kernel, not a parameter).
> 

IMHO there where reasons why the standards are defining a function
to access this information from applications.

