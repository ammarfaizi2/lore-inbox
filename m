Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751018AbWFDTsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFDTsQ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWFDTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 15:48:15 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:28372 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751007AbWFDTsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 15:48:15 -0400
Message-ID: <44833955.9000104@free.fr>
Date: Sun, 04 Jun 2006 21:49:41 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
References: <200606040252_MC3-1-C195-28D9@compuserve.com>
In-Reply-To: <200606040252_MC3-1-C195-28D9@compuserve.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04.06.2006 08:49, Chuck Ebbert a écrit :
> In-Reply-To: <44809D5E.8020107@free.fr>
> 
> On Fri, 02 Jun 2006 22:19:42 +0200, Laurent Riffard wrote:
> 
>> OK, here is a new report done with 2.6.17-rc5-mm2 + hotfixes (namely 
>> genirq-msi-fixes-2.patch, lock-validator-x86_64-irqflags-trace-entrys-fix.patch,
>> revert-git-cfq.patch).
>>
>> linux-2.6-mm$ grep UNWIND .config
>> CONFIG_UNWIND_INFO=y
>> # CONFIG_STACK_UNWIND is not set
> 
> Something strange is happening with the stack.  Can you try with 8K stacks?
> 
> kernel hacking --->
>    [ ] Use 4Kb for kernel stacks instead of 8Kb
> 

Good catch!

I just tried with 2.6.17-rc5-mm3. The BUG still happens with 4K stacks,
but the system runs fine with 8K stacks.

Another info: the system is able to run fine with the following scenario,
even with 4K stack:
- boot to runlevel 1
- load pktcdvd (modprobe + pktsetup)
- then go to runlevel 5 
It fails if pktcdvd is loaded at runlevel 2 or higher.

-- 
laurent
