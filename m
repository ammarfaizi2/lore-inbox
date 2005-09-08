Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVIHOjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVIHOjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVIHOjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:39:33 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2653
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751372AbVIHOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:39:32 -0400
Message-Id: <432069850200007800024427@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:40:37 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ELF definitions addition
References: <4320670B0200007800024411@emea1-mh.id2.novell.com> <20050908143216.GA9665@infradead.org>
In-Reply-To: <20050908143216.GA9665@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 08.09.05 16:32:16 >>>
>On Thu, Sep 08, 2005 at 04:30:03PM +0200, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>> 
>> A trivial addition to the EFL definitions.
>
>Why?  They're obviously not needed in kernelspace..

I have dependent code (on STT_COMMON), and am in the process of
breaking this up. Since the definition doesn't hurt anyone (and I need
it), I can't see why it can't be there; I agree that STT_TLS will rarely
be needed in kernel code, but I still decided to also add this for
completeness.

>> 
>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>> 
>> diff -Npru 2.6.13/include/linux/elf.h
2.6.13-elf/include/linux/elf.h
>> --- 2.6.13/include/linux/elf.h	2005-08-29 01:41:01.000000000
+0200
>> +++ 2.6.13-elf/include/linux/elf.h	2005-03-16 12:24:42.000000000
>> +0100
>> @@ -150,6 +150,8 @@ typedef __s64	Elf64_Sxword;
>>  #define STT_FUNC    2
>>  #define STT_SECTION 3
>>  #define STT_FILE    4
>> +#define STT_COMMON  5
>> +#define STT_TLS     6
>>  
>>  #define ELF_ST_BIND(x)		((x) >> 4)
>>  #define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)
>> 

