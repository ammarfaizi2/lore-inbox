Return-Path: <linux-kernel-owner+w=401wt.eu-S1754838AbXABNoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXABNoM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbXABNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:44:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:37385 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbXABNoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:44:11 -0500
In-Reply-To: <20070102102930.650db9ac.khali@linux-fr.org>
References: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org> <20061222104056.GB7009@in.ibm.com> <20070101223913.7b1fddbf.khali@linux-fr.org> <20070102061147.GA30308@in.ibm.com> <20070102102930.650db9ac.khali@linux-fr.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4a3cca1be4bf059806a9108953a26709@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Alexander van Heukelum <heukelum@fastmail.fm>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Date: Tue, 2 Jan 2007 14:44:05 +0100
To: Jean Delvare <khali@linux-fr.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Segher had suggested to use .section command to specifically mark
>> .text.head section as AX (allocatable and executable) to solve the
>> problem.

Great to hear it works in real life too.

Here, have a From: line (or how should this patch history be
encoded?) :-)

From: Segher Boessenkool <segher@kernel.crashing.org>
>> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
>> ---
>>
>>  arch/i386/boot/compressed/head.S |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff -puN arch/i386/boot/compressed/head.S~jean-reboot-issue-fix  
>> arch/i386/boot/compressed/head.S
>> ---  
>> linux-2.6.20-rc2-reloc/arch/i386/boot/compressed/head.S~jean-reboot- 
>> issue-fix	2007-01-02 09:54:56.000000000 +0530
>> +++  
>> linux-2.6.20-rc2-reloc-root/arch/i386/boot/compressed/head.S	2007-01 
>> -02 09:57:46.000000000 +0530
>> @@ -28,7 +28,7 @@
>>  #include <asm/page.h>
>>  #include <asm/boot.h>
>>
>> -.section ".text.head"
>> +.section ".text.head","ax",@progbits
>>  	.globl startup_32
>>
>>  startup_32:

