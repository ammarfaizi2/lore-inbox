Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVICAaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVICAaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbVICAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:30:15 -0400
Received: from smtpout.mac.com ([17.250.248.45]:30463 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161087AbVICAaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:30:13 -0400
In-Reply-To: <dfapgu$dln$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B04E819E-73CD-44E5-9BFF-5ED3ADAF8515@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 20:30:03 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 20:07:58, H. Peter Anvin wrote:
> Followup to:  <20050902235833.GA28238@codepoet.org>
> By author:    Erik Andersen <andersen@codepoet.org>
> In newsgroup: linux.dev.kernel
>> <uClibc maintainer hat on>
>> That would be wonderful.
>> </off>
>>
>> It would be especially nice if everything targeting user space
>> were to use only all the nice standard ISO C99 types as defined
>> in include/stdint.h such as uint32_t and friends...
>
> Absolutely not.  This would be a POSIX namespace violation; they
> *must* use double-underscore types.

I would actually be more inclined to provide and use types like
_kabi_{s,u}{8,16,32,64}, etc.  Then the glibc/klibc/etc authors would
have the option of just doing "typedef _kabi_u32 uint32_t;" in their
header files.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


