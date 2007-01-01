Return-Path: <linux-kernel-owner+w=401wt.eu-S933253AbXAAIU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbXAAIU4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933254AbXAAIU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:20:56 -0500
Received: from il.qumranet.com ([62.219.232.206]:55352 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933253AbXAAIUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:20:55 -0500
Message-ID: <4598C465.5070308@qumranet.com>
Date: Mon, 01 Jan 2007 10:20:53 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [PATCH 4/8] KVM: Implement a few system configuration msrs
References: <45939755.7010603@qumranet.com> <20061228101117.65A392500F7@il.qumranet.com> <200701010107.18008.ioe-lkml@rameria.de>
In-Reply-To: <200701010107.18008.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi,
>
> On Thursday, 28. December 2006 11:11, Avi Kivity wrote:
>   
>> Index: linux-2.6/drivers/kvm/svm.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/kvm/svm.c
>> +++ linux-2.6/drivers/kvm/svm.c
>> @@ -1068,6 +1068,9 @@ static int emulate_on_interception(struc
>>  static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
>>  {
>>  	switch (ecx) {
>> +	case 0xc0010010: /* SYSCFG */
>> +	case 0xc0010015: /* HWCR */
>> +	case MSR_IA32_PLATFORM_ID:
>>  	case MSR_IA32_P5_MC_ADDR:
>>  	case MSR_IA32_P5_MC_TYPE:
>>  	case MSR_IA32_MC0_CTL:
>>     
>
> What about just defining constants for these?
> Then you can rip out these comments.
>
> Same for linux-2.6/drivers/kvm/vmx.c
>   

Yes, there are a few more of these as well.  I'll clean them up once 
things quiet down a bit.

-- 
error compiling committee.c: too many arguments to function

