Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUENJhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUENJhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUENJhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:37:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:4802 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S264522AbUENJhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:37:48 -0400
Date: Fri, 14 May 2004 18:39:22 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: MMUless CPU support?
In-reply-to: <20040513174521.A10776@flint.arm.linux.org.uk>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel mailing-list <linux-kernel@vger.kernel.org>
Message-id: <40A493CA.7030702@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
References: <200405040617.42342.jeffs@fairwayacademy.org>
 <409AC200.7020106@mailcan.com> <20040507084536.A14179@flint.arm.linux.org.uk>
 <409B97E4.8010100@snapgear.com> <20040507194740.A5778@flint.arm.linux.org.uk>
 <409E3752.3050102@snapgear.com> <20040509152414.C17714@flint.arm.linux.org.uk>
 <409EC97D.7030105@samsung.com> <20040510094435.B27722@flint.arm.linux.org.uk>
 <409F62D5.6080500@samsung.com> <20040510123124.C27722@flint.arm.linux.org.uk>
 <409F7341.4090207@samsung.com> <042601c43905$beed50e0$0100a8c0@SHUTTLE>
 <20040513174521.A10776@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux wrote:

>On Thu, May 13, 2004 at 06:17:09PM +0200, Vadim Lebedev wrote:
>  
>
>>Hyok,
>>
>>about fork and mmap syscalls on uClinux:
>>
>>actually i believe it would be better to leave calls.S untouched and return
>>EINVAL or similar in the C level code...
>>BTW, if i remember correctly (it was in 97 when i've ported uClinux 2.0.xx
>>from 68000 to ARM7) mmap call was partially functionnal on ucLinux
>>(depending
>>on arguments) so
>> there is no need to scrap it from calls.S too....
>>
>>the less we touch .S file the eathier it'll be to maintain the NO-MMU
>>version
>>    
>>
>
>And you can use assembler/linker magic to alias sys_fork to
>sys_ni_syscall.
>
>Since Hyok seems to be 100% against any kind of merge, it's useless
>even talking about this though.
>  
>
Hmm, I think about the clean and well structured kind of merge. His 
comment was useful for me. :-)

I always think almost all of tricky method to cross among codes is NO 
good, for maintainer, code readers, porting guys and all.
I like Vadim's method.

Regards,
Hyok
