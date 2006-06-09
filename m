Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWFIFKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWFIFKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWFIFKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:10:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65491 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965202AbWFIFK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:10:29 -0400
Message-ID: <4489030F.4020004@in.ibm.com>
Date: Fri, 09 Jun 2006 10:41:43 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fix Compilation error for UM Linux
References: <44883C68.8010307@in.ibm.com> <20060608104655.70c6836f.akpm@osdl.org>
In-Reply-To: <20060608104655.70c6836f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 08 Jun 2006 20:34:08 +0530
> Suzuki <suzuki@in.ibm.com> wrote:
> 
> 
>>Hi,
>>
>>This patch fixes the compilation error for UM Linux with linux-2.6.17-rc5.
>>
>>It complains of using (void *) in arithmetic.
> 
> 
> Really?  We often do arithmetic on void*.  Are you using gcc, with standard
> kbuild and standard compiler options?

Ah ! I was using g++ since the kernel had some C++ code in it. Sorry for 
the same.

> 
> 
>>Thanks.
>>
>>Suzuki K P
>>Linux Technology Center,
>>IBM Software Labs.
>>
>>
>>
>>* Fix the compilation error for um-linux.
>>
>>Signed Off by: Suzuki K P <suzuki@in.ibm.com>
> 
> 
> "Signed-off-by:", please.
Sorry ! Will take care of it from now onwards.


Thanks,

Suzuki
> 
> 
>>--- arch/um/include/mem.h       2006-05-25 01:45:04.000000000 -0700
>>+++ arch/um/include/mem.h~fix_compilation_error 2006-06-08 
>>07:46:21.000000000 -0700
>>@@ -22,7 +22,7 @@ static inline unsigned long to_phys(void
>>
>>  static inline void *to_virt(unsigned long phys)
>>  {
>>-       return((void *) uml_physmem + phys);
>>+       return (void *) (uml_physmem + phys);
>>  }
>>
>>  #endif
