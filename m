Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWEDWLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWEDWLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWEDWLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:11:05 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:35726 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750811AbWEDWLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:11:04 -0400
In-Reply-To: <6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org> <6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Thu, 4 May 2006 17:10:56 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
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


On May 4, 2006, at 5:09 PM, Segher Boessenkool wrote:

> Hi Kumar,
>
>> +static int ppc_panic_event(struct notifier_block *this,
>> +                             unsigned long event, void *ptr)
>> +{
>> +	ppc_md.panic((char *)ptr);  /* May not return */
>> +	return NOTIFY_DONE;
>> +}
>
> Lose the redundant pointer cast while you're there please?
>
>>  void __init setup_arch(char **cmdline_p)
>>  {
>>  	extern void do_init_bootmem(void);
>> +	extern void setup_panic(void);
>
> Can those two go into a header file please?

any suggestions on which header?
