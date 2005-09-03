Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVICAeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVICAeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVICAeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:34:20 -0400
Received: from terminus.zytor.com ([209.128.68.124]:31459 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751242AbVICAeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:34:19 -0400
Message-ID: <4318EF83.1010401@zytor.com>
Date: Fri, 02 Sep 2005 17:34:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <B04E819E-73CD-44E5-9BFF-5ED3ADAF8515@mac.com>
In-Reply-To: <B04E819E-73CD-44E5-9BFF-5ED3ADAF8515@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Sep 2, 2005, at 20:07:58, H. Peter Anvin wrote:
> 
>> Followup to:  <20050902235833.GA28238@codepoet.org>
>> By author:    Erik Andersen <andersen@codepoet.org>
>> In newsgroup: linux.dev.kernel
>>
>>> <uClibc maintainer hat on>
>>> That would be wonderful.
>>> </off>
>>>
>>> It would be especially nice if everything targeting user space
>>> were to use only all the nice standard ISO C99 types as defined
>>> in include/stdint.h such as uint32_t and friends...
>>
>>
>> Absolutely not.  This would be a POSIX namespace violation; they
>> *must* use double-underscore types.
> 
> 
> I would actually be more inclined to provide and use types like
> _kabi_{s,u}{8,16,32,64}, etc.  Then the glibc/klibc/etc authors would
> have the option of just doing "typedef _kabi_u32 uint32_t;" in their
> header files.
> 

They have to be *double-underscore*.

We have that.  They're called __[su]{8,16,32,64}.

	-hpa
