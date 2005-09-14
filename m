Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVINNkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVINNkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVINNkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:40:00 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34063 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965185AbVINNkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:40:00 -0400
Message-ID: <4328299C.9020904@tmr.com>
Date: Wed, 14 Sep 2005 09:46:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com>
In-Reply-To: <dfapgu$dln$1@terminus.zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <20050902235833.GA28238@codepoet.org>
> By author:    Erik Andersen <andersen@codepoet.org>
> In newsgroup: linux.dev.kernel
> 
>><uClibc maintainer hat on>
>>That would be wonderful.
>></off>
>>
>>It would be especially nice if everything targeting user space
>>were to use only all the nice standard ISO C99 types as defined
>>in include/stdint.h such as uint32_t and friends...
>>
> 
> 
> Absolutely not.  This would be a POSIX namespace violation; they
> *must* use double-underscore types.

Could you explain why you think it would be a violation to use POSIX 
types instead of defining our own? That's what the types are for, to 
avoid having everyone define some slightly conflicting types.

The kernel predates C99, sort of, and it would be a massive but valuable 
  task to figure out where a type is really, for instance, 32 bits 
rather than "size of default int" in length, etc, and use POSIX types 
where they are correct. Fewer things to maintain, and would make it 
clear when something is 32 bits by default and when it really must be 32 
bits.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
