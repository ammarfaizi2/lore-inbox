Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282236AbRLDGl6>; Tue, 4 Dec 2001 01:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282248AbRLDGlj>; Tue, 4 Dec 2001 01:41:39 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:37394 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP
	id <S282236AbRLDGlc>; Tue, 4 Dec 2001 01:41:32 -0500
Message-ID: <3C0C701C.8000606@xmission.com>
Date: Mon, 03 Dec 2001 23:41:32 -0700
From: Ben Carrell <ben@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011201
X-Accept-Language: en
MIME-Version: 1.0
To: "Daniel T. Chen" <crimsun@email.unc.edu>
CC: safemode <safemode@speakeasy.net>, real <haxmail@subdimension.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Compilation error with Kernels 2.4.16 && 2.5.X
In-Reply-To: <Pine.A41.4.21L1.0112040113310.59820-100000@login3.isis.unc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That would explain why I could compile fine when 2.4.16 was released, 
but not now....Thanks -- anytime frame you know of for a fix?

-Ben Carrell
ben@xmission.com

Daniel T. Chen wrote:

>Upon further investigation this is related to the specific version of
>binutils used in linking the kernel after compilation. Please see
>http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=122179&repeatmerged=yes
>for more details. Additionally, not all kernel .configs will trigger
>it. The USB segment is definitely in a common point, though. 2.2 kernels
>don't seem to exhibit it; but any 2.4 with certain .configs will.
>
>---
>Dan Chen                 crimsun@email.unc.edu
>GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc
>
>On 4 Dec 2001, safemode wrote:
>
>>On Mon, 2001-12-03 at 09:54, real wrote:
>>
>>>drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols 
>>>in discarded section .text.exit'
>>>drivers/net/net.o(.data+0xbb4): undefined reference to `local symbols in 
>>>discarded section .text.exit'
>>>drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local 
>>>symbols in discarded section .text.exit'
>>>drivers/usb/usbdrv.o(.data+0x234): undefined reference to `local symbols 
>>>in discarded section .text.exit'
>>>make: *** [vmlinux] Error 1
>>>
>>Same here.  How many other people are finding this to be a problem?   
>>same problem with 2.4.17-pre2  
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>



