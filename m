Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281403AbRKZCJ6>; Sun, 25 Nov 2001 21:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKZCJr>; Sun, 25 Nov 2001 21:09:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63505 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281403AbRKZCJb>; Sun, 25 Nov 2001 21:09:31 -0500
Message-ID: <3C01A441.6070702@zytor.com>
Date: Sun, 25 Nov 2001 18:09:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
In-Reply-To: <1432.1006740397@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> 
> kbuild 2.5 does
>   '-nostdinc -I/usr/lib/gcc-lib/... gcc version ../include/'
> so it allows includes from the compiler headers.  The problem is:
> 
>   bonding.c includes limits.h, picked up from gcc, OK.
>   limits.h includes syslimits.h from gcc, OK.
>   syslimits.h tries to include_next <limits.h> to get the user space
>   limits, not OK.
> 
> Any kernel code that includes limits.h or syslimits.h is polluted by
> user space headers.  net/bonding.c does not even need limits.h.
> 

How UTTERLY braindamaged... I guess we could provide a (dummy?) 
<limits.h> for the kernel environment.  I would definitely like to see 
the standard compiler-related headers like <stdint.h> as well...

	-hpa

