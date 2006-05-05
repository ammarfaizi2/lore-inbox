Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWEEE7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWEEE7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 00:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWEEE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 00:59:39 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:2717 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932465AbWEEE7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 00:59:39 -0400
In-Reply-To: <17498.34041.993647.189930@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org> <17498.34041.993647.189930@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <900DA3FF-3DF2-43AA-A8EA-869E95B7431F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Thu, 4 May 2006 23:59:35 -0500
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 4, 2006, at 5:49 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Please pull from 'for_paulus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>
>> --- a/arch/powerpc/kernel/setup_32.c
>> +++ b/arch/powerpc/kernel/setup_32.c
>> @@ -236,6 +236,7 @@ arch_initcall(ppc_init);
>>  void __init setup_arch(char **cmdline_p)
>>  {
>>  	extern void do_init_bootmem(void);
>> +	extern void setup_panic(void);
>
> Urk.

Yeah didn't care for it either.  Will move to "setup.h"

>
>> @@ -285,6 +286,9 @@ #endif
>>  	/* reboot on panic */
>>  	panic_timeout = 180;
>>
>> +	if (ppc_md.panic)
>> +		setup_panic();
>
> Since no 32-bit platform sets ppc_md.panic AFAICS, I guess this
> doesn't need to be pushed into 2.6.17.  Please redo with setup_panic
> declared in a header file.

Yeah, this was for 2.6.18. (will do on the header change)

- k
