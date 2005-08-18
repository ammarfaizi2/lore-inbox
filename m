Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVHRQZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVHRQZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHRQZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:25:37 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:23228 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932261AbVHRQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:25:37 -0400
In-Reply-To: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
References: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
Cc: <hch@infradead.org>, <davem@davemloft.net>, <paulus@samba.org>,
       "Gala Kumar K.-galak" <galak@freescale.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>,
       <zach@vmware.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
Date: Thu, 18 Aug 2005 11:25:19 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 17, 2005, at 5:07 AM, Miklos Szeredi wrote:

>>> They are provided by _one_ kernel, not necessarily the running
>>>
> kernel.
>
>>
>> No, they're provided by packages like glibc-kernheaders or similar
>> that are maintained separately.
>>
>
> Yes.  And "maintenance" I presume means "copy" the kernel headers and
> do some cleanup to be compliant to the relevant standards (which the
> kernel maintainers couldn't be bothered to do).
>
>
>> They're split from the kernel headers and we don't need to keep
>> obsolete junk around.
>>
>
> I agree about obsolete junk.
>
> However statements like "No kernel headers can be included by userland
> anymore" can be slightly misleading.

So after all of this its not clear to me if its acceptable to kill  
all users of <asm/segment.h> in the kernel and to move code that  
exists in <asm/segment.h> to <asm/uaccess.h> for arch's that need it.

- kumar
